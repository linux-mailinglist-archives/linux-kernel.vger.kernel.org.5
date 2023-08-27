Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D4C78A360
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjH0XUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjH0XUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:20:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E28B2;
        Sun, 27 Aug 2023 16:20:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A868E1F37E;
        Sun, 27 Aug 2023 23:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693178412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hpfZdKefCmR3XkIHcJvJm+LczI/wWWwMh1lPsmhqngk=;
        b=Ltw7KmepQcM4WdkWbEwaiRQl7TNL/woBoLBXnScmienIBCeiBo7hYpEq4bTZ1HdJ488GE6
        +mkGaDvy6tn88jXSKDd4rAKcLWkFiO/yKiiPoovrdtVLTyJid05/wnAexIkrf4H58eMCd/
        4ERGeUUMRaZ8mbo79g2lUP7UGJjufFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693178412;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hpfZdKefCmR3XkIHcJvJm+LczI/wWWwMh1lPsmhqngk=;
        b=Ica3YJUL7u/mI5agU5KGF4GHw+PdjdNz3r7rd8EG0f/d2wMOIRAokAF3QHfvTI4TOp187a
        +JaSs1o+sjDwckDA==
Received: from lion.mk-sys.cz (unknown [10.163.31.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 431A12C143;
        Sun, 27 Aug 2023 23:20:11 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id E4C2C2016F; Mon, 28 Aug 2023 01:20:08 +0200 (CEST)
Date:   Mon, 28 Aug 2023 01:20:08 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     mkubeck@suse.cz, yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH ethtool] hns3: add support dump registers for hns3 driver
Message-ID: <20230827232008.tjcuolelsdhh7o44@lion.mk-sys.cz>
References: <20230818085611.2483909-1-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rozjvojegsvvb5re"
Content-Disposition: inline
In-Reply-To: <20230818085611.2483909-1-shaojijie@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rozjvojegsvvb5re
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 04:56:11PM +0800, Jijie Shao wrote:
> Add support pretty printer for the registers of hns3 driver.
> This printer supports PF and VF, and is compatible with hns3
> drivers of earlier versions.
>=20
> Sample output:
>=20
> $ ethtool -d eth1
> [cmdq_regs]
>   comm_nic_csq_baseaddr_l : 0x48168000
>   comm_nic_csq_baseaddr_h : 0x00000000
>   comm_nic_csq_depth      : 0x00000080
>   comm_nic_csq_tail       : 0x00000050
>   comm_nic_csq_head       : 0x00000050
>   comm_nic_crq_baseaddr_l : 0x48170000
>   comm_nic_crq_baseaddr_h : 0x00000000
>   comm_nic_crq_depth      : 0x00000080
>   comm_nic_crq_tail       : 0x00000000
>   comm_nic_crq_head       : 0x00000000
>   comm_vector0_cmdq_src   : 0x00000000
>   comm_cmdq_intr_sts      : 0x00000000
>   comm_cmdq_intr_en       : 0x00000002
>   comm_cmdq_intr_gen      : 0x00000000
> [common_regs]
>   misc_vector_base    : 0x00000001
>   pf_other_int        : 0x00000040
>   misc_reset_sts      : 0x00000000
>   misc_vector_int_sts : 0x00000000
>   global_reset        : 0x00000000
>   fun_rst_ing         : 0x00000000
>   gro_en              : 0x00000001
> ...
>=20
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
[...]
> --- /dev/null
> +++ b/hns3.c
[...]
> +#pragma pack(4)
> +struct hns3_reg_tlv {
> +	u16 tag;
> +	u16 len;
> +};
> +
> +struct hns3_reg_header {
> +	u64 magic_number;
> +	u8 is_vf;
> +	u8 rsv[7];
> +};
> +
> +#pragma pack()

Could we please avoid these #pragma directives? AFAIK this is a Microsoft
extension, which, while implemented in gcc for compatibility reasons, is
not very common in linux world. To be honest, I had to search the web to
see what exactly does it do - and even after that, only checking the object
file with gdb revealed that it does not really do anything except weakening
the alignment of struct hns3_reg_header (as a whole). Given how the
structure is used in this file, the only practical effect would be
header_len in hns3_dump_regs() being 12 rather than 16 (on 64-bit
architectures).

Michal

--rozjvojegsvvb5re
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmTr2iQACgkQ538sG/LR
dpVmPAgAtitFlqjYMeCYBZHE5I3ZxYzUroOSXvFYxgVR/Rt0LtwXy/4RINWdcj4m
sv9xEkopCTRQ+seX2FlxmdGer6L9ZuTV7ey4YTyHjxxpKUxiKfA5y12XkLBpL0gj
yDU6+ZdAGiwffYaPwh8HiH85rASwdmahZX7eX9Ukq5rIhakekSGFHgceHzDybB2A
lSX9dMf6V9lQV6L2wqXVDNtJBdLYB0YaeZoFBWJ+uz5G1VGC99T6t0OnQTxJqtfJ
xleN9S8PdHc+pjlF+Zb4sykFAEGjNxSqUAsUTkqUj8JVPRNieWwuRHJ4RUO61mDd
pwMoPjK1Br6RfBcIQHAbdhresuyKmQ==
=otZj
-----END PGP SIGNATURE-----

--rozjvojegsvvb5re--
