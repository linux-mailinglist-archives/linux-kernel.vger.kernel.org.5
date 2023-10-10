Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1A67BF480
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442569AbjJJHjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442547AbjJJHjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:39:14 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AC1AF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 00:39:12 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso64705521fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 00:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1696923551; x=1697528351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9HLjKQphoF1al/8pr129PFMpYKqfXvTRFbRdIYZSXY=;
        b=WBfuEJXCLueaZuWoYq7WZtqSz5XtQzFmIlkkIoGm5+pPyIJNqCfBpTaOpImhbFCYBY
         Q+ahHeiGEJc1LmOcEkKXedqqU9hGv39B6Y4WIrc+Xh63PpQ+CW16eqxuMm5XMEyU4DTh
         YggdI8jY/TP8cLlcc0P/MJ99ZXNK/2putFhzLmgtPM55Hnnwtq0JJ84VDWisdLQEe/0B
         aMtm8BUbJWa6VGzwJRY3uD5P+hTubOHnGfLH+0oZa/Q1NS2lb74fRW1OJ7CFt5KPjjTp
         p4HPLGo6v/NPuyczsJtv7JkAigCug9A6Fk+MJe7Q1UTnyMwEORp/yjfGVg+FhIWlKfMa
         cuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696923551; x=1697528351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9HLjKQphoF1al/8pr129PFMpYKqfXvTRFbRdIYZSXY=;
        b=tYvLFk1cZ75cgwL5hgtHi8eaMaJ43ALRPfP/GEaf2UsCkkNF/TMl/xXHBcU4hZgAEO
         SLW290Ah6t2c9kSb7Exz8B8eo/z+cFjpcxn5vVSY/OA+DF8X/w6myaHO8ZmMbZmeckdT
         d/T5oSJnRrzmC9ZK05jDYq/LsQrHMHR8qSnOjJGdxR8FCzmON0u9Gr4xj8d9PJD7LMfD
         9lX/6ufpSrDxiAn8wKatkN04HQBqO/SWQMHK1wyEWy2Bv2fovkBIKDef8DRM/YFWraQA
         ho/O5CtAG/Bj1qcKylbjEPJUeSz+tZKgBfvkqtuagsnlGb8lyu2ykTG+ew2mvFDoqzke
         4x1A==
X-Gm-Message-State: AOJu0YwQNQcFjJgweuZ7WlKQXszxES5GyDlqDpmk+F6k3AowYgdn7a5x
        wFopA+z2gn+4x6SJG5d3tlFfpP26BYLcuIXL2eDQEbxMp3xh5D5hhTE=
X-Google-Smtp-Source: AGHT+IHrmhpZIdd5zcic3MUiuhRIn34+0lpjncVRTXZnMi9qzr53DzLFQwtj/OiltQ9OMSRLop5NwgADPdrIQjIYAoQ=
X-Received: by 2002:a2e:9bd2:0:b0:2bf:e855:8cbf with SMTP id
 w18-20020a2e9bd2000000b002bfe8558cbfmr13923869ljj.35.1696923550959; Tue, 10
 Oct 2023 00:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231009165741.746184-1-max.kellermann@ionos.com>
 <20231009165741.746184-6-max.kellermann@ionos.com> <264fa39d-aed6-4a54-a085-107997078f8d@roeck-us.net>
 <CAKPOu+8k2x1CucWSzoouts0AfMJk+srJXWWf3iWVOeY+fWkOpQ@mail.gmail.com> <f511170fe61d7e7214a3a062661cf4103980dad6.camel@perches.com>
In-Reply-To: <f511170fe61d7e7214a3a062661cf4103980dad6.camel@perches.com>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Tue, 10 Oct 2023 09:38:59 +0200
Message-ID: <CAKPOu+_xPGdKuSdwh9NdKT+RGw1=JbpkBB3+GK0qnC8KbTyY7Q@mail.gmail.com>
Subject: Re: [PATCH 6/7] fs/sysfs/group: make attribute_group pointers const
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 8:48=E2=80=AFAM Joe Perches <joe@perches.com> wrote=
:
> My opinion is that const use in the kernel should almost
> always have whitespace before and after it except when
> preceded by a open parenthesis or a newline.

So it shall be "void * const foo" (16k occurrences in the kernel)
instead of "void *const foo" (3k occurrences)?
