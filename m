Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCEB7C620B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 03:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbjJLBIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 21:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbjJLBIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 21:08:14 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E1BA4;
        Wed, 11 Oct 2023 18:08:12 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9a6b21d1daso495455276.3;
        Wed, 11 Oct 2023 18:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697072891; x=1697677691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4XdKBSiKJOkL+MzxkZtnmYwHSE6NfuwxJcHbqMJt+4=;
        b=FJ94F66VXsi58wqSCmeCfWcUX8k0hSO9Q7Qhu3nvVoHsATkymZm8dXO52JY14y3ll6
         bjG+GpI6Eky3kXw8J/oOO+GTu8EaepGzSuXEtrl4cyd4tJCjfnFOzPGcvyLZL40qo5m+
         /JlGp00YtJXJelZcDzSgHUwQeat2M4Y2sehXIArYESncgPFRyAf4GS3bIrKG/sKaI+8b
         +OEiDSX+6WP4vG6pkwzd6g7IZQGi0axbadkcBA9UYQIahMSR1jqRHm11jz0NzD6tGSrh
         XVPBddbPTXD3Yw5diimhdnPPKj+kNV0LpYohuQx+Lj+lsmqVykDcSmuTvokXEYeh44Uq
         8+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697072891; x=1697677691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4XdKBSiKJOkL+MzxkZtnmYwHSE6NfuwxJcHbqMJt+4=;
        b=qlVQo6J5sUW5FstCTm/kH6dYWCvBuExR/eiGjYUvz4LXrEeQDOnosmlR3PpGK4BdK7
         7H/A3ciyxUZ3EMKrXfzLzInuWL4hI8/Mt6llLJvVIsA/fcoGUxmimiip2W5VpVPZBja7
         GtQZryxe2I2C+h1FFsqw9LN75B5R4VTUyNe7JIe4G/wHAzK9O5puRhm1BUT0sM0HgJW8
         l9kK1z0HyHOZbcW5QuKmBY/D/N8CVNrHXj6i1WVeiCLmR70tjlYm+WU6roMcQ9IxR1PS
         fS6UHHcJdsueVe2AEhTQZzLTTQknXmFF74cPa23n3iFKEHhZRBF38yTRkiEr8Z/EMmBC
         uTRA==
X-Gm-Message-State: AOJu0YxnazZBnzZcc3ZDXc29QzeSYGizfBC6uKk1UUQh0G4GVfzXhD+4
        Ve9+YPDohyrLa6apRhp2w4iF7owG5E3ZpXjIrCc=
X-Google-Smtp-Source: AGHT+IENr/oeTnryZo3bVL80RuzCr5idt3tau25ZS+cjq7Apkt1xk7gcwUo3mPHZ5MeRrlTvJsvSbuCgoTiKZlb82eE=
X-Received: by 2002:a25:18c1:0:b0:d81:61fd:ef5d with SMTP id
 184-20020a2518c1000000b00d8161fdef5dmr18975896yby.27.1697072891447; Wed, 11
 Oct 2023 18:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231008075221.61863-1-hayatake396@gmail.com> <20231010123235.4a6498da@kernel.org>
 <CADFiAcKF08osdvd4EiXSR1YJ22TXrMu3b7ujkMTwAsEE8jzgOw@mail.gmail.com>
 <20231010191019.12fb7071@kernel.org> <CADFiAcL-kAzpJJ+KAkvw2tH8H0-21kyOusPSPybcmkf3CM7w9g@mail.gmail.com>
 <20231011094114.4d8f24c7@kernel.org>
In-Reply-To: <20231011094114.4d8f24c7@kernel.org>
From:   takeru hayasaka <hayatake396@gmail.com>
Date:   Thu, 12 Oct 2023 10:08:00 +0900
Message-ID: <CADFiAc+67wdcS5enobbty-_U9SGX9Mr-C_0ipU_KJAV+h-t_Tg@mail.gmail.com>
Subject: Re: [PATCH net-next] ethtool: ice: Support for RSS settings to GTP
 from ethtool
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I think we should expose TEID as a field. It's easier to understand
> the API if fields are all listed, and not implied by the flow hash.

Jakub san Thank you for your feedback!
I would like to make changes and send them as a patch for the next version.

2023=E5=B9=B410=E6=9C=8812=E6=97=A5(=E6=9C=A8) 1:41 Jakub Kicinski <kuba@ke=
rnel.org>:
>
> On Wed, 11 Oct 2023 14:25:55 +0900 takeru hayasaka wrote:
> > > Regarding the patch - you are only adding flow types, not a new field
> > > (which are defined as RXH_*). If we want to hash on an extra field,
> > > I think we need to specify that field as well?
> >
> > I've been really struggling with this...
> > When I read the Intel ICE documentation, it suggests that in RSS, TEID
> > can be an additional input.
> > However, I couldn't think of a reason not to include TEID when
> > enabling RSS for GTP cases.
> >
> > https://www.intel.com/content/www/us/en/content-details/617015/intel-et=
hernet-controller-e810-dynamic-device-personalization-ddp-technology-guide.=
html
> > (cf. Table 8. Patterns and Input Sets for iavf RSS)
> >
> > However, for Flow Director, it's clear that you'd want to include the
> > TEID field. But since I found that someone from Intel has already
> > configured it to use TEID with Flow Director, I thought maybe we don't
> > need to add the TEID parameter for now.
> >
> > https://patchwork.ozlabs.org/project/intel-wired-lan/cover/202101260652=
06.137422-1-haiyue.wang@intel.com/
> >
> > If we want to include something other than TEID (e.g., QFI) in Flow
> > Director, I think it would be better to prepare a new field.
>
> I think we should expose TEID as a field. It's easier to understand
> the API if fields are all listed, and not implied by the flow hash.
