Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6263C7C62B9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjJLC1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjJLC1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:27:03 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5208B6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:27:01 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53da72739c3so824623a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1697077620; x=1697682420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uAVbdAI/t4kp4F0w7o3XfjGK/x3xwElaYSG4Wap1s0=;
        b=SGZe1AfUk0omF01bhlOoqzan1SZglYgEK5f0qkT2MBckNIayIYVb1mqNJfgJx1ZeKN
         0z9nM6GW998cDVX2c3uGqd82ToPSR22Q054CC1Fk0fkTF5KQqBbypONRlT+pWGQCV4kd
         ZdchkeLjM0DqoD4uxDHpkW3O3+XJy0pS8Lv6dxbSRZfEt3nI5EibJYpYXGukIxt8xRAe
         SdVOjI44RBSfSeT/Gb8gfhkcg3AsmIi+rd6XgN0L0vvA55ulCJT9PFs5XZdaLMELNK6F
         uDgIABmIQ63JtXkeXvVNfWOyqqJw+NzwrEcvl1E6gLpDBkNK8ycUfGjRmEiPCXcPRwh+
         sSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697077620; x=1697682420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uAVbdAI/t4kp4F0w7o3XfjGK/x3xwElaYSG4Wap1s0=;
        b=NFWz4C7WYCgoWwWVA+k0wrltEw2S4anNwnZ1XDfWbF9rgq2k+1ys7uaSSDzIdBLUuH
         1jWHJ1MiOtwhR+08aLsCz0xL+EGIjTiikTJ46PWdmNP1OjBrqzFXxKW9dNDd+FvJaPGn
         R3A//EJrAO1ecINhyFMYOkmt1UVToErHcd9/kCyXVu7c8DTJ5MJNPHRkuGAk5JP3jO+q
         EQpHVkJ4Ny43pL96eFVq77GmMn/VLRE5rRjLB2GTrZiMtEmyWSEpDnWzk6qiwrlLaQmg
         5TxtPvX/ozyceqEyD7gnt23hy686csqC6/q7402GeGVKfcQBr/fOWa2i0EUf7bYTzrBT
         GaUw==
X-Gm-Message-State: AOJu0YyWBDzDWL8lrMupoQMr2CF2sBbjid+L0Xh6xbWn18shseWvvYQ8
        boyr9fZ0cD1w85ct46aGqVqWecQzHRy/SUMZLpDmTQ==
X-Google-Smtp-Source: AGHT+IEBboUS4cwn4e3Ys9mXQ4ZCkgfLdr7atTruR6S+lBb7qdwzHO/3JSrHZfVGLZdiOBdEoTiN3ePEBse1tsA5adw=
X-Received: by 2002:a05:6402:5194:b0:53e:395:59d with SMTP id
 q20-20020a056402519400b0053e0395059dmr726299edd.8.1697077620310; Wed, 11 Oct
 2023 19:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231009100349.52884-1-yizhou.tang@shopee.com> <cf850508-498b-4748-955c-382906eff676@acm.org>
In-Reply-To: <cf850508-498b-4748-955c-382906eff676@acm.org>
From:   Tang Yizhou <yizhou.tang@shopee.com>
Date:   Thu, 12 Oct 2023 10:26:49 +0800
Message-ID: <CACuPKxm+YtdierSLCTiqn3qEcgexM6O7AwVQrgSGq5mz8bJDog@mail.gmail.com>
Subject: Re: [PATCH] doc: blk-ioprio: Standardize a few names
To:     Bart Van Assche <bvanassche@acm.org>, houtao1@huawei.com,
        jack@suse.cz, kch@nvidia.com
Cc:     axboe@kernel.dk, tj@kernel.org, corbet@lwn.net,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, yingfu.zhou@shopee.com,
        chunguang.xu@shopee.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your suggestion, I will fix it in the next version.

Thanks,
Tang


On Wed, Oct 11, 2023 at 8:05=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 10/9/23 03:03, yizhou.tang@shopee.com wrote:
> > From: Tang Yizhou <yizhou.tang@shopee.com>
>
> The title of this patch is misleading. The title suggests that the
> user interface is changed, which is not the case. What this patch does
> is to bring the documentation in sync with the implementation.
>
> Otherwise this patch looks fine to me.
>
> Thanks,
>
> Bart.
