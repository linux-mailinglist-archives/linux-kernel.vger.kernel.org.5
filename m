Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23607F5C17
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbjKWKRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbjKWKRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:17:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5181AD48
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700734668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BSpKpo4O4iiJunkafEGTSLneyzxvVWYkfJt2rrOos2k=;
        b=LfZleArhOqCNYxVTUJYSiINoh1fOm4YzqyFI/GfmYBYCq/Jvm8SJ/UKXLqwPPUoVYkTUAc
        ZYZt/+rYpzf9Wt0yO2IGfJ7wSRWpvOWXSTIGn+lz17TUV3/BMEecYI8R8HfLqgpXHJLJKl
        yvpVx3PpNObKf7I7rCAE+0t9hr7g7j0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-0XdCXAVfMV2U9ak8hWGykg-1; Thu, 23 Nov 2023 05:17:46 -0500
X-MC-Unique: 0XdCXAVfMV2U9ak8hWGykg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-548e6717ab7so67078a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:17:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700734666; x=1701339466;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BSpKpo4O4iiJunkafEGTSLneyzxvVWYkfJt2rrOos2k=;
        b=nMHANR9Zd4/kDa+JXh2WmivYNJ+hoJWPIUJtLChXK+nPB5WErAsD79MLWVP9rd+jE3
         wnj2FTP/sxDtbFDgSckvRzWz29XT4t3dbfflvltlUhys8ei/bpi6tfbR/i86gi5rLVXq
         3P5rlN4nqjiCsoFhxLG28+VOuiw2R0McGpt6GZOj0kyBrQ1fx36yAHA6LGxmz8Iagu2p
         MS7kUDWpIXFXIPOHH4w3HjckUfMoofirLdGr/NZgnyfd3emMBNxnrzQ/zts20t0gqpZh
         u+z773eM93fZzJ5j5c1XcIQoto5rXKn52c51YvmKlMksAiLGxFxpNns2lgt2P71s32e8
         0Vog==
X-Gm-Message-State: AOJu0YycM+aDDNsArfFryxX51Rq5QePHi7rjT6Kme0Yj/5UpfCP3kXKS
        Q3dARRw03TP3t4V8+pd64UH01+4AH5j9QI1A5AZJAxggdSFhV3Nvr8ZAQO6W8nLKnDXriii/jhH
        NMfna+OcK9SPt+BQ3+qzEAC3j
X-Received: by 2002:aa7:ca41:0:b0:549:aeb:4f8e with SMTP id j1-20020aa7ca41000000b005490aeb4f8emr3495952edt.4.1700734665794;
        Thu, 23 Nov 2023 02:17:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGV2rt46oNutILQDl/fbaKsy+1nsv9w1ooHRAhPaK/Ceb3py1DfDTeXb6gNqX+a/LGmebwSeA==
X-Received: by 2002:aa7:ca41:0:b0:549:aeb:4f8e with SMTP id j1-20020aa7ca41000000b005490aeb4f8emr3495934edt.4.1700734665406;
        Thu, 23 Nov 2023 02:17:45 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-213.dyn.eolo.it. [146.241.241.213])
        by smtp.gmail.com with ESMTPSA id l17-20020a056402345100b00546d9d81ec8sm481013edc.93.2023.11.23.02.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 02:17:45 -0800 (PST)
Message-ID: <15c047f8121a501d8fbef8713d2d9e1fd4a564ad.camel@redhat.com>
Subject: Re: [net-next PATCH v3 1/2] octeontx2-af: Add new mbox to support
 multicast/mirror offload
From:   Paolo Abeni <pabeni@redhat.com>
To:     Suman Ghosh <sumang@marvell.com>, sgoutham@marvell.com,
        gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        lcherian@marvell.com, jerinj@marvell.com, horms@kernel.org,
        wojciech.drewek@intel.com
Date:   Thu, 23 Nov 2023 11:17:43 +0100
In-Reply-To: <20231121094346.3621236-2-sumang@marvell.com>
References: <20231121094346.3621236-1-sumang@marvell.com>
         <20231121094346.3621236-2-sumang@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-11-21 at 15:13 +0530, Suman Ghosh wrote:
[...]
> +static int nix_add_mce_list_entry(struct rvu *rvu,
> +				  struct nix_hw *nix_hw,
> +				  struct nix_mcast_grp_elem *elem,
> +				  struct nix_mcast_grp_update_req *req)
> +{
> +	struct mce *tmp_mce[NIX_MCE_ENTRY_MAX];

If I read correctly the above struct is is 256 bytes wide. Do you
really need to put so much data on the stack this deep?=20


> +	u32 num_entry =3D req->num_mce_entry;
> +	struct nix_mce_list *mce_list;
> +	struct mce *mce;
> +	int i;
> +
> +	mce_list =3D &elem->mcast_mce_list;
> +	for (i =3D 0; i < num_entry; i++) {
> +		mce =3D kzalloc(sizeof(*mce), GFP_KERNEL);
> +		if (!mce)
> +			goto free_mce;
> +
> +		mce->pcifunc =3D req->pcifunc[i];
> +		mce->channel =3D req->channel[i];
> +		mce->rq_rss_index =3D req->rq_rss_index[i];
> +		mce->dest_type =3D req->dest_type[i];
> +		mce->is_active =3D 1;
> +		hlist_add_head(&mce->node, &mce_list->head);
> +		tmp_mce[i] =3D mce;
> +		mce_list->count++;
> +	}
> +
> +	mce_list->max +=3D num_entry;
> +
> +	/* Dump the updated list to HW */
> +	if (elem->dir =3D=3D NIX_MCAST_INGRESS)
> +		return nix_update_ingress_mce_list_hw(rvu, nix_hw, elem);
> +
> +	nix_update_egress_mce_list_hw(rvu, nix_hw, elem);
> +	return 0;
> +
> +free_mce:
> +	while (i) {
> +		hlist_del(&tmp_mce[i-1]->node);
> +		kfree(tmp_mce[i-1]);

Minor nit: checkpatch complains about the above: spaces are needed
around '-'.

> +		mce_list->count--;
> +		i--;
> +	}
> +
> +	return -ENOMEM;
> +}
> +
>  static int nix_update_mce_list_entry(struct nix_mce_list *mce_list,
>  				     u16 pcifunc, bool add)
>  {

[...]
> @@ -3237,13 +3473,30 @@ static int nix_setup_mcast(struct rvu *rvu, struc=
t nix_hw *nix_hw, int blkaddr)
>  	int err, size;
> =20
>  	size =3D (rvu_read64(rvu, blkaddr, NIX_AF_CONST3) >> 16) & 0x0F;
> -	size =3D (1ULL << size);
> +	size =3D BIT_ULL(size);
> +
> +	/* Allocate bitmap for rx mce entries */
> +	mcast->mce_counter[NIX_MCAST_INGRESS].max =3D 256UL << MC_TBL_SIZE;
> +	err =3D rvu_alloc_bitmap(&mcast->mce_counter[NIX_MCAST_INGRESS]);
> +	if (err)
> +		return -ENOMEM;
> +
> +	/* Allocate bitmap for tx mce entries */
> +	mcast->mce_counter[NIX_MCAST_EGRESS].max =3D MC_TX_MAX;
> +	err =3D rvu_alloc_bitmap(&mcast->mce_counter[NIX_MCAST_EGRESS]);
> +	if (err) {
> +		rvu_free_bitmap(&mcast->mce_counter[NIX_MCAST_INGRESS]);
> +		return -ENOMEM;
> +	}
> =20
>  	/* Alloc memory for multicast/mirror replication entries */
>  	err =3D qmem_alloc(rvu->dev, &mcast->mce_ctx,
> -			 (256UL << MC_TBL_SIZE), size);
> -	if (err)
> +			 mcast->mce_counter[NIX_MCAST_INGRESS].max, size);
> +	if (err) {
> +		rvu_free_bitmap(&mcast->mce_counter[NIX_MCAST_INGRESS]);
> +		rvu_free_bitmap(&mcast->mce_counter[NIX_MCAST_EGRESS]);
>  		return -ENOMEM;
> +	}
> =20
>  	rvu_write64(rvu, blkaddr, NIX_AF_RX_MCAST_BASE,
>  		    (u64)mcast->mce_ctx->iova);
> @@ -3256,8 +3509,12 @@ static int nix_setup_mcast(struct rvu *rvu, struct=
 nix_hw *nix_hw, int blkaddr)
>  	size =3D rvu_read64(rvu, blkaddr, NIX_AF_MC_MIRROR_CONST) & 0xFFFF;
>  	err =3D qmem_alloc(rvu->dev, &mcast->mcast_buf,
>  			 (8UL << MC_BUF_CNT), size);
> -	if (err)
> +	if (err) {
> +		rvu_free_bitmap(&mcast->mce_counter[NIX_MCAST_INGRESS]);
> +		rvu_free_bitmap(&mcast->mce_counter[NIX_MCAST_EGRESS]);
> +		qmem_free(rvu->dev, mcast->mce_ctx);

AFAICS, the above lines frees struct that was already allocated prior
to this patch. It looks like a fix possibly worthy a separate patch.

[...]
> +static void nix_mcast_update_mce_entry(struct rvu *rvu, u16 pcifunc, u8 =
is_active)
> +{
> +	struct nix_mcast_grp_elem *elem;
> +	struct nix_mcast_grp *mcast_grp;
> +	struct nix_hw *nix_hw;
> +	int blkaddr;
> +
> +	blkaddr =3D rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
> +	nix_hw =3D get_nix_hw(rvu->hw, blkaddr);
> +	if (!nix_hw)
> +		return;
> +
> +	mcast_grp =3D &nix_hw->mcast_grp;
> +
> +	mutex_lock(&mcast_grp->mcast_grp_lock);
> +	list_for_each_entry(elem, &mcast_grp->mcast_grp_head, list) {
> +		struct nix_mce_list *mce_list;
> +		struct mce *mce;
> +
> +		/* Iterate the group elements and disable the element which
> +		 * received the disable request.
> +		 */
> +		mce_list =3D &elem->mcast_mce_list;
> +		hlist_for_each_entry(mce, &mce_list->head, node) {
> +			if (mce->pcifunc =3D=3D pcifunc) {
> +				if (is_active)
> +					mce->is_active =3D 1;
> +				else
> +					mce->is_active =3D 0;

just:

				mce->is_active =3D is_active;

> +
> +				break;
> +			}
> +		}
> +
> +		/* Dump the updated list to HW */
> +		if (elem->dir =3D=3D NIX_MCAST_INGRESS)
> +			nix_update_ingress_mce_list_hw(rvu, nix_hw, elem);
> +		else
> +			nix_update_egress_mce_list_hw(rvu, nix_hw, elem);
> +
> +		/* Update the multicast index in NPC rule */
> +		nix_mcast_update_action(rvu, elem);
> +	}
> +	mutex_unlock(&mcast_grp->mcast_grp_lock);
> +}
> +
>  int rvu_mbox_handler_nix_lf_start_rx(struct rvu *rvu, struct msg_req *re=
q,
>  				     struct msg_rsp *rsp)
>  {

[...]
> @@ -5797,3 +6134,327 @@ int rvu_mbox_handler_nix_bandprof_get_hwinfo(stru=
ct rvu *rvu, struct msg_req *re
> =20
>  	return 0;
>  }
> +
> +static struct nix_mcast_grp_elem *rvu_nix_mcast_find_grp_elem(struct nix=
_mcast_grp *mcast_grp,
> +							      u32 mcast_grp_idx)
> +{
> +	struct nix_mcast_grp_elem *iter, *result_iter =3D NULL;
> +
> +	mutex_lock(&mcast_grp->mcast_grp_lock);
> +	list_for_each_entry(iter, &mcast_grp->mcast_grp_head, list) {
> +		if (iter->mcast_grp_idx =3D=3D mcast_grp_idx) {
> +			result_iter =3D iter;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&mcast_grp->mcast_grp_lock);
> +
> +	return result_iter;

What prevents 'result_iter' from being freed at this point? (and
causing a later UaF)

> +}
> +
> +int rvu_nix_mcast_get_mce_index(struct rvu *rvu, u16 pcifunc, u32 mcast_=
grp_idx)
> +{
> +	struct nix_mcast_grp_elem *elem;
> +	struct nix_mcast_grp *mcast_grp;
> +	struct nix_hw *nix_hw;
> +	int blkaddr;
> +
> +	blkaddr =3D rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
> +	nix_hw =3D get_nix_hw(rvu->hw, blkaddr);
> +	if (!nix_hw)
> +		return NIX_AF_ERR_INVALID_NIXBLK;
> +
> +	mcast_grp =3D &nix_hw->mcast_grp;
> +	elem =3D rvu_nix_mcast_find_grp_elem(mcast_grp, mcast_grp_idx);
> +	if (!elem)
> +		return NIX_AF_ERR_INVALID_MCAST_GRP;
> +
> +	return elem->mce_start_index;
> +}
> +
> +void rvu_nix_mcast_flr_free_entries(struct rvu *rvu, u16 pcifunc)
> +{
> +	struct nix_mcast_grp_destroy_req dreq =3D { 0 };
> +	struct nix_mcast_grp_update_req ureq =3D { 0 };
> +	struct nix_mcast_grp_update_rsp ursp =3D { 0 };
> +	struct nix_mcast_grp_elem *elem, *tmp;
> +	struct nix_mcast_grp *mcast_grp;
> +	struct nix_hw *nix_hw;
> +	int blkaddr;
> +
> +	blkaddr =3D rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
> +	nix_hw =3D get_nix_hw(rvu->hw, blkaddr);
> +	if (!nix_hw)
> +		return;
> +
> +	mcast_grp =3D &nix_hw->mcast_grp;
> +
> +	mutex_lock(&mcast_grp->mcast_grp_lock);
> +	list_for_each_entry_safe(elem, tmp, &mcast_grp->mcast_grp_head, list) {
> +		struct nix_mce_list *mce_list;
> +		struct hlist_node *tmp;
> +		struct mce *mce;
> +
> +		/* If the pcifunc which created the multicast/mirror
> +		 * group received an FLR, then delete the entire group.
> +		 */
> +		if (elem->pcifunc =3D=3D pcifunc) {
> +			mutex_unlock(&mcast_grp->mcast_grp_lock);
> +			/* Delete group */
> +			dreq.hdr.pcifunc =3D elem->pcifunc;
> +			dreq.mcast_grp_idx =3D elem->mcast_grp_idx;
> +			rvu_mbox_handler_nix_mcast_grp_destroy(rvu, &dreq, NULL);
> +			mutex_lock(&mcast_grp->mcast_grp_lock);

What prevents 'tmp' from being removed and freed while the
'mcast_grp_lock' is not held? there are other similar chunks later.

I'm under the impression that all the multicast data is touched under
the rtnl lock protection so the above lock does not matter much, but I
really did not validate such impression/guess.

Generally speaking the lock schema here looks complex and hard to
follow: a more descriptive changelog will help.

Cheers,

Paolo

