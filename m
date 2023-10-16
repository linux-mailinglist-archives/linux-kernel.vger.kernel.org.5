Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4487CACF4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjJPPGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjJPPGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:06:46 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0DED9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:06:45 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d9ac45092e7so5154625276.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697468804; x=1698073604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JPLLbFfi+3DcdR4lMb9bxT1Efqz3WnKELubajvCf/8=;
        b=dagC2NQY29AS3Upuik35O6nqJ8zXL3qZIbhmlUeyEHTa5xsoWW8EXpxGWIC3jdlgvP
         5OIPBMdEQ5LjLZwJk5kr/40hLiHfRcWQS6iemI39AY6srmG0LKt2/ZYH9nVrMoVquag2
         uR9p6GEoOSN4mioIM/WN2CFSg+mB2od5Brd5GA9K/6UIHwqXwrNmQE0qqWiQnxIXrnXT
         2Igh9t/uvVwet52Yx/myMeYwqyGBo7aYH6hvhLg3ld6lq7SCU8NePOKh6bhRfebvW5mR
         Em++plsgl7iF0+7F7p5VBEbeN0Hrk5PZTp8P6m/fR5B/21Q8UeomsnXqGHCO+oMl/5N9
         Wmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697468804; x=1698073604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JPLLbFfi+3DcdR4lMb9bxT1Efqz3WnKELubajvCf/8=;
        b=V15XDPr2bWiikEqcHHk0imAR1jVNq75sus+RbkFbzVrk+KlaGUSmR5yVLQ+dMTPn/1
         uNfZbv4RHrG2Su/5/LXcUUOcXxR7vjqyJ+7APZs7VoGfZ/U0uUqD6g26Qru/fCOJ6WCG
         H+hwYiZKwRle0rzG7A2FBLXZfvAIMZNbH1d5cBcFCv+Q7Kkm+/jCP/RyaY5rl6SHvD3l
         hwv7/lmBn5K9Yi37gLFIrMUkcttQ7Y/fZgd1xr0+cvUx1iyyu+tUVtpVIUTTdPDKCSMR
         CJPeqxrwXiILSN6DuQ6Memtd09VbfnS8UVJz8XE34Dp9O6bu61gyVc4k0Yoxe1UoKwxB
         YcxA==
X-Gm-Message-State: AOJu0YwTBv5PHRcTt2k2h8wLUVWQfRlZ1w9/EOEodsc44/2/euF0S6px
        JdZTDYYWM6hkzw6TWQ4tNpyWYFbovXf/hIAB4kKZ
X-Google-Smtp-Source: AGHT+IGDqKl7MND9wZqcX+N6HWeeMu6HHtgNjthMSWYuYqtbmsB/+9mEShdOg4gGou5EhGsCNoZVqcXb9rZceJuQ6gU=
X-Received: by 2002:a25:ae8b:0:b0:d9a:d20d:7d5a with SMTP id
 b11-20020a25ae8b000000b00d9ad20d7d5amr13002821ybj.1.1697468804361; Mon, 16
 Oct 2023 08:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230912205658.3432-1-casey.ref@schaufler-ca.com>
 <20230912205658.3432-1-casey@schaufler-ca.com> <CAHC9VhRcbp3iWQwL7FTUrcU1C3OsZ413Nbq+17oTwW7hZ7XvBw@mail.gmail.com>
 <CAHC9VhSqY5+DR-jXprrftb1=CzDvhTh0Ep66A16RMd4L7W7TYw@mail.gmail.com> <ae39864947debbc7c460db478b8abe1c147b7d5c.camel@huaweicloud.com>
In-Reply-To: <ae39864947debbc7c460db478b8abe1c147b7d5c.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 16 Oct 2023 11:06:33 -0400
Message-ID: <CAHC9VhRQ7xpeSX7b3VZfzQ15noJ8mgauNMuHWo_n3hMgsYMAfQ@mail.gmail.com>
Subject: Re: [PATCH v15 00/11] LSM: Three basic syscalls
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 8:05=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> Sorry, I just noticed LSM_ID_IMA. Since we have the 'integrity' LSM, I
> think it should be LSM_ID_INTEGRITY.
>
> Mimi, all, do you agree? If yes, I send a patch shortly.

I believe LSM_ID_IMA is the better option, despite "integrity" already
being present in Kconfig and possibly other areas.  "IMA" is a
specific thing/LSM whereas "integrity" is a property, principle, or
quality.  Especially as we move forward with promoting IMA as a full
and proper LSM, we should work towards referring to it as "IMA" and
not "integrity".

If anything we should be working to support "IMA" in places where we
currently have "integrity" so that we can eventually deprecate
"integrity".

--=20
paul-moore.com
