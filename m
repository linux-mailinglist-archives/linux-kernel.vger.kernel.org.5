Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B864475B2C1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjGTPd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjGTPdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:33:21 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4024D26BF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:32:53 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f14865fcc0so3480e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689867168; x=1690471968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ELXOHdH0Sgv1ShIJJf2v8s+u66DzEk9BmCJpgYUgm8=;
        b=aVZfy1jyFULL3IEcVMRZL6b7kRxuG6XmloV4lM36S295Y0TZWNEkLpdzhq+neC+WlW
         MtJcxU4KR5hAky5n3cWLF+MHJDIBD0YzkyQQDgSdZ0zPRnDXWSm9QEyNAS5/0S+rci/h
         naMqdH4XjNy2tcjVQN92nGWApll64DcsUlIuYT9+RloPLpwijzfPBFTUVDzmzDj4tD+9
         VMyq8Qsl6SR4aXlfGuh/x6Ey0PJth5cySqLom4oLMwi1L9RiV3SIZaFN59E8B9GLsGZ8
         W8TeKuOTtxQGyOBc7VmfRPoPpRdpRKbpf96wFaQWwWHMl7hcgLVrHBggMHknxxvwpvVX
         cwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689867168; x=1690471968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ELXOHdH0Sgv1ShIJJf2v8s+u66DzEk9BmCJpgYUgm8=;
        b=RjfFxZmiGDvThv5azRsPIQDlIoa3e2P0a+eTBZsBJTjbHt2h6Q8Caad5xerzQSOLLj
         104Z/BFIGjSW51crb/MUGuReoDvOu6R2Fs6h4GzfADF+A6EzQGLTDC9wwuwv6O2GwINq
         L8fy6aw4ioDHHoiACS43HbggKBrb/rtbeoaELm9+8iVhZSXKghhijCXVCs1ZBLr656bx
         UCzw7N7L1+uuVtRN5Sb9WpS3VkTakRkB4BHTmg+q1XchFQtDPJASKKb2TV5hQAC0lO9O
         kyyYdpichBQxL2+NyeFHFAJBcKzzrQhFI6bQZ8L4W4du6g6Q0CKU4Yvze0NRa0/ELXJB
         Zm4Q==
X-Gm-Message-State: ABy/qLZRNEAiNZl90rNlzVoT/3vfZSYgpKT6+XmSZsHvHUrAEER4lXa7
        6PMxs+hM2+Kz4TYlh+R9xgAiL6ie5issc0uSWmracA==
X-Google-Smtp-Source: APBJJlH67+hjFEun9PR449BIyfYQxVI0PbjrBpMJJIpYw5cq/Mbaj2tRdf7QQXdjeKtsn7sAmRlGNAjTfQnIGfcOSe4=
X-Received: by 2002:ac2:5541:0:b0:4fd:d54e:3e58 with SMTP id
 l1-20020ac25541000000b004fdd54e3e58mr75638lfk.4.1689867168505; Thu, 20 Jul
 2023 08:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230720124611.45b25256@canb.auug.org.au> <ZLi/gg2HLgwt5JR3@google.com>
In-Reply-To: <ZLi/gg2HLgwt5JR3@google.com>
From:   Rob Barnes <robbarnes@google.com>
Date:   Thu, 20 Jul 2023 09:32:11 -0600
Message-ID: <CA+Dqm31A6GNOpXB00X0aRd5TOpDgRAuTNh0Ce5YKm5EN+15gyg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the chrome-platform tree
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch to fix this issue was submitted here:
https://lore.kernel.org/lkml/221b9a4a-275f-80a4-bba6-fb13a3beec0a@roeck-us.=
net/T/

However, it's looking unlikely that it will be accepted. So I think we
should revert a6edd5f5d9cc for now. Let me know if I need to submit a
revert patch?

On Wed, Jul 19, 2023 at 11:00=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org>=
 wrote:
>
> On Thu, Jul 20, 2023 at 12:46:11PM +1000, Stephen Rothwell wrote:
> > After merging the chrome-platform tree, today's linux-next build (x86_6=
4
> > allmodconfig) failed like this:
> >
> > ERROR: modpost: "emergency_sync" [drivers/platform/chrome/cros_ec_lpcs.=
ko] undefined!
> >
> > Caused by commit
> >
> >   a6edd5f5d9cc ("platform/chrome: cros_ec_lpc: Emergency sync filesyste=
m on EC panic")
> >
> > I have used the chrome-platform tree from next-20230719 for today.
>
> Thanks for reporting.  I have dropped the commit from chrome-platform for=
-next
> branch.
