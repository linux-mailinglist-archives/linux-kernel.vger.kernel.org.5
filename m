Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22217BF321
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442258AbjJJGdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442233AbjJJGdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:33:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB55097
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 23:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696919551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K9kT46zzJ4Pv/uNaGDbttTONHdzkYaHl6vJNLUy+dGg=;
        b=F8KkOmIYqpcWBbzZe1e4X0jk6ZyFNc6h4Sllubqc5YyINeEioKadLAoLc0O9Rt3HozTsDe
        WtvffX48ZzocRd3XtRczN/Zz0rdN8wJo6rXmMYN0S12MVueeSe6ogtPG3uxJPg+XrHpnAI
        Cj5SFc6I46Iwojyh6130F7zxYoeTh3E=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-P0AO5V-APCimtunsDwSBvQ-1; Tue, 10 Oct 2023 02:32:14 -0400
X-MC-Unique: P0AO5V-APCimtunsDwSBvQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50433ca6d81so4875790e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 23:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696919533; x=1697524333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9kT46zzJ4Pv/uNaGDbttTONHdzkYaHl6vJNLUy+dGg=;
        b=BAoXH5afg6xSSBdRZ8EXSAgHyvbFozDwc1vIHxYPwGUDCWFK7sVsEYEnQjwSiMYEcS
         fi24ghmJTa10h5lIz5Ku4DbtcOHM4/OfHy9zs/B8fd0B7LeJXfA610v3msFgYVnQgNHf
         HYalujrrwshRVrquB3iJWJvKGg7TSzmGBmgiP+DAV7uZJ0RVJZXOSPcffrU6YfVM6CwB
         1+CI+DxkXgJBXoXOQzIY5izpeMTJW8iVt3X6yKl17a53hg6suCYL6cgFBJvhTdLQlZWS
         zt1l+RyzA8/vA3hUquNbLnIrupgC+u4vkp1JRVZE7VIEqhdqa+2gfl43cWwPSLXZJbPA
         7EJg==
X-Gm-Message-State: AOJu0Yx6w7ANBd9YEzU9FThyQ8Jt6Z/XllbdnB7rQ0KkVM+2IoZsowkm
        7B0kWC9szFFobI61kltelxER4fwdmTSdTWHx4PYDtNaoNVa+5brmAo5uvXM69hPjVgsJeScsMk2
        SQDCo+rwjbWNTEmvejS/fRsWdCRQGMWw41BeaHcD6
X-Received: by 2002:a05:6512:2392:b0:4f9:54f0:b6db with SMTP id c18-20020a056512239200b004f954f0b6dbmr18049561lfv.13.1696919533191;
        Mon, 09 Oct 2023 23:32:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMuNalqFHbo9fbkOLQicOz6Sn3F911SHVPCJzCScea/EKBEn2jF2zne4YSBmcfHq0eewz0GZHEAMKr2KCyjms=
X-Received: by 2002:a05:6512:2392:b0:4f9:54f0:b6db with SMTP id
 c18-20020a056512239200b004f954f0b6dbmr18049550lfv.13.1696919532918; Mon, 09
 Oct 2023 23:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231009112401.1060447-1-dtatulea@nvidia.com> <20231009112401.1060447-15-dtatulea@nvidia.com>
In-Reply-To: <20231009112401.1060447-15-dtatulea@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 10 Oct 2023 14:32:02 +0800
Message-ID: <CACGkMEtmwW_GdHqY-9+pioOZU79nJHc_bWn-iStahDNg7r=06A@mail.gmail.com>
Subject: Re: [PATCH vhost v3 14/16] vdpa/mlx5: Enable hw support for vq
 descriptor mapping
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Parav Pandit <parav@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 7:25=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> Vq descriptor mappings are supported in hardware by filling in an
> additional mkey which contains the descriptor mappings to the hw vq.
>
> A previous patch in this series added support for hw mkey (mr) creation
> for ASID 1.
>
> This patch fills in both the vq data and vq descriptor mkeys based on
> group ASID mapping.
>
> The feature is signaled to the vdpa core through the presence of the
> .get_vq_desc_group op.
>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

