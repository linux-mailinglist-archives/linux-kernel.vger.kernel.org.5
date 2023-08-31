Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59A278EF86
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346448AbjHaOXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245118AbjHaOXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:23:25 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7601ED7;
        Thu, 31 Aug 2023 07:23:22 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-58fae4a5285so10485237b3.0;
        Thu, 31 Aug 2023 07:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693491801; x=1694096601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phnYXnSwWYOm/UrIYicT3LwK5knpPtBGCKUUkfNelbQ=;
        b=TnVWlKyAaXosPvOpjW/hcnop8ot39ZOxOqWfPO4BGZYLKA2wpJWMaFSDCB+y4qNtYm
         9ovy2lZkqjbYhwcIOmMGzvw/LjQ1rKBdM/NyxIWBCu87KRpZJHI28yaTQr7qGxuNhNu1
         p6TblmSzaVNSCiMdPmtPx02hUN+79o3G8crW3yxp5GLh7e7eLRQc3MZDeacAVke4lP1K
         Edyct5i0i5zv0E+aHjBV09Cg4US/l+cKrffu60ozR80iQZTx2axLGxh6AgV4A3Cw2egv
         KNwQcSY3eHkmBgRb5Ck1Vtilrv67J3lBXBvtx3i1B/mzB9m4bxkfF61m0g8050Ey6+KE
         PTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693491801; x=1694096601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phnYXnSwWYOm/UrIYicT3LwK5knpPtBGCKUUkfNelbQ=;
        b=DsNMDvhkUW89DFxvS2HrCYI/0osuFwgzJUt+17uqrzYZovKxxq86O1QC8CgM5bKnRV
         0zQOtH8sMAXyh+SmMGh24aDM569rbvW0By4AHG8h4kiR9td4I/aZnXHoOw3NrpGEke4/
         JZtMdw4Tw6AbIJlFxSGMblerkLt59jJxnsPEuhZ6gSwq5NYakSu/sT0ZJTcHBxOPWu8t
         OTu51eJE2jUmj70smTxoRRa2Wh2DOCRRxlNfCiKbWFNXjeq62ukNuiiSdQCVzCb4n0h0
         kivIpJT0tbrcME/KHh5IZXc6J/LIWuDOJm+kxjm3axlpvTK0A8LLP1EZeum8XZ4Z8gAO
         sYtA==
X-Gm-Message-State: AOJu0YylBWsuvNiJzAd0ZAAWgQ+159uusMZsPvnjHV0iowsrr4GoXPrN
        IvggYWEZzqJgwnyFFU3EvlAcmDo+RdYSc/ZaS/A=
X-Google-Smtp-Source: AGHT+IFpFoTmnpihBB/Pw0oyIfC2l2F9mEbN62s05Pr0jK+gJ6rj2uKu8LSANGcaoyRa5qr2X1zRxzLAjLkGgo8DGVo=
X-Received: by 2002:a25:5006:0:b0:d7b:9f03:20cc with SMTP id
 e6-20020a255006000000b00d7b9f0320ccmr5237427ybb.32.1693491801543; Thu, 31 Aug
 2023 07:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230830160410.3820390-1-azeemshaikh38@gmail.com>
 <2023083035-unpadded-amulet-8c7e@gregkh> <CADmuW3Wbgb7s+jRm8F0hcjzreWysVdzNvv778yUbGCOxAJHwjQ@mail.gmail.com>
 <202308301421.997C4034B5@keescook> <aa488b1d-51b2-7b55-7a8d-552306ca16dd@foxvalley.net>
 <202308301646.8397A6A11@keescook> <82b80554-2042-7dcb-83c5-6a6b640c71be@foxvalley.net>
In-Reply-To: <82b80554-2042-7dcb-83c5-6a6b640c71be@foxvalley.net>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Thu, 31 Aug 2023 10:23:10 -0400
Message-ID: <CADmuW3UUGc_1m+Bcs7YUnp40S+8vN-W8nUQv2-nmj_oTb360QQ@mail.gmail.com>
Subject: Re: [PATCH] vt: Fix potential read overflow of kernel memory
To:     Dan Raymond <draymond@foxvalley.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 1:45=E2=80=AFAM Dan Raymond <draymond@foxvalley.net=
> wrote:
>
> On 8/30/2023 5:48 PM, Kees Cook wrote:
> > Warning: This email is from an unusual correspondent.
> > Warning: Make sure this is someone you trust.
> >
> > On Wed, Aug 30, 2023 at 05:17:12PM -0600, Dan Raymond wrote:
> >> In my opinion strlcpy() is being used correctly here as a defensive
> >> precaution.  If the source string is larger than the destination buffe=
r
> >> it will truncate rather than corrupt kernel memory.  However the
> >> return value of strlcpy() is being misused.  If truncation occurred
> >> the copy_to_user() call will corrupt user memory instead.
> >>
> >> I also agree that this is not currently a bug.  It is fragile and it
> >> could break if someone added a very large string to the table.
> >>
> >> Why not fix this by avoiding the redundant string copy?  How about
> >> something like this:
> >>
> >> ptr =3D func_table[kb_func] ? : "";
> >> len =3D strlen(ptr);
> >>
> >> if (len >=3D sizeof(user_kdgkb->kb_string))
> >>      return -ENOSPC;
> >>
> >> if (copy_to_user(user_kdgkb->kb_string, ptr, len + 1))
> >>      return -EFAULT;
> >
> > This would work if not for func_buf_lock. The bounce buffer is used to
> > avoid needing to hold the spin lock across copy_to_user.
> >
>
> Ah you're right.  Thanks for setting me straight.  Now I realize that my
> entire assessment was wrong.  The original author was not using strlcpy()
> as a defensive measure to prevent a buffer overflow.  He was using it so
> that he could create a copy of the string and measure its length using
> only one pass.  This minimizes the time spent holding the spinlock.
>
> The surrounding code was written such that a buffer overflow is
> impossible.  No additional checks are needed.  The proposed patch is
> unnecessary.  But at least it preserves the spirit of the original
> author's code by performing only one pass of the source string
> while holding the spinlock.

Are folks ok with me sending out a v2 for this with a better commit
log that explains the issue?
