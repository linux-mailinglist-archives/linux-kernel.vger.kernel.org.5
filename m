Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5937DC531
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 05:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbjJaENX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 00:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJaENU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 00:13:20 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB7AC0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 21:13:17 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4083cd3917eso40777545e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 21:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698725596; x=1699330396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JWzjKL8EVaea5V4HLaN3vFp8o2Efb8rSuCQYLqGhPNM=;
        b=UJqJsr4IY8SWQWHQrwo63Cdu9z855WLD6CI5CPNWuuz4z6QaTYbBEgilaoeGh7zsjl
         1gJ/fm0wYHwmRLB/IIx30arW5ndhbmVjtUKymvw6aws5zoFXpr+L5uYIQSf6u1Ipjoqc
         wglG/2fvWf8fuJGNDVhOIi+AlMxk7jUdltUnzXCyK9cNMEnrk3cDwtHp/h3ph4XhZoth
         uIAJllqNYsXjE8/GowbZ7/uUuItuxz0v8/bpVtBrjj4ipLU/LbI+Pddl6pJfBYe2HMlg
         6nmZF91Q0Ue0YRZHt/6siz64UY1pjWjUpPFEevZHK/+BNo1VHkDCfg6I/qzvHMNOdWn6
         7zaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698725596; x=1699330396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWzjKL8EVaea5V4HLaN3vFp8o2Efb8rSuCQYLqGhPNM=;
        b=okW44lwr61W/BcUKb7FYugew55W1M8nXZrIphP37VhheNnIXzJpyquL5R/edEnhtAP
         vMDG+OnhLJzARsk9XRmNwOjUZJGTHv/3pd94kGYjPT5eZCYsEpgkD+X9HLiaBi9dMUTu
         9wDZa1mMxOQOZtVak5qSWOhn6wbpbUAjwAqw4egyu6X3q3K8kROR2/zkY7BJDx/vkAvZ
         kMOTHg9TVqqMnzmy7IjMzhtrs3Mi8BOR6EE7HqNTVZ8Au7MJ0jBgKudYatFJ03BHoK5Y
         HuLqOQh2JiWwIfK105KuwwodDlJQhxBiz0ehGBt7FdQPkY45FNI+TMGCDOXanj+B7JnT
         pbcQ==
X-Gm-Message-State: AOJu0YznQtnPe+u9DySLqDCOprukXNfzUlp4X/ZcYXNLc0Pd/GRqUFCT
        r++xVHFaQKNnG8V5kug/vMCT2g==
X-Google-Smtp-Source: AGHT+IEPDxyOOgvptCIl3Y4Jak1XAQ25YdaQBYIEe+oAxOQClDi6eyZMDdGcKmIP/s9FKFQJNYn1og==
X-Received: by 2002:a05:600c:458f:b0:408:3ac4:dc3f with SMTP id r15-20020a05600c458f00b004083ac4dc3fmr10053328wmo.29.1698725595302;
        Mon, 30 Oct 2023 21:13:15 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c229000b0040596352951sm549895wmf.5.2023.10.30.21.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 21:13:14 -0700 (PDT)
Date:   Tue, 31 Oct 2023 07:13:12 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Nancy Nyambura <nicymimz@gmail.com>
Cc:     nicydaniels@gmail.com, outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Staging: rts5208: Replace strncpy() with strscpy()
Message-ID: <191cf6e2-6a46-4813-a0c4-c86bcf9bd0b2@kadam.mountain>
References: <20231030142751.49913-1-nicymimz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030142751.49913-1-nicymimz@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 05:27:47PM +0300, Nancy Nyambura wrote:
> Warning found by checkpath.pl
> I replaced strncpy with strscpy because strscpy is suitable when the
> destination buffer is NUL-terminated, which is often the case when
> copying strings. Strscpy ensures that the destination buffer is
> properly NUL-terminated without padding.

The same is basically true for strncpy()...  In olden days strncpy()
was the only "safe" function we had so we used it exactly how we use
strscpy() today except we manually added a NUL terminator to the end.

	new = kzalloc(len + 1, GFP_KERNEL);
	strncpy(new, old, len);

> In the code, the objective is to copy a string (inquiry_string) to the
> buf buffer, and it's likely that the buf buffer is NUL-terminated
> since it is handling a string. Strscpy_pad is used when you have
> afixed-size buffer, and you want to copy a string into it while
> ensuring the remaining space is padded with a specific character
> (like '\0') hence not appropriate for this context.
> 

You need to run your patches through checkpatch.

"it's likely that the buf buffer is NUL-terminated since it is handling
a string."  That's not analysis.  That's just guessing.  Take what time
you need and do the analysis.

"Strscpy_pad is used when you have afixed-size buffer, and you want to
copy a string into it while ensuring the remaining space is padded with
a specific character (like '\0') hence not appropriate for this context."

It's not "like '\0'" it's specifically '\0'...  This explains what
strscpy_pad() does.  We all know what it does.  No need to explain that.
However this doesn't explain *why* it's not appropriate.

1) Look at buf.  How big is it?  What data is stored in buf before we do
   the strncpy().
2) Look at inquiry_string.  Where does it come from?  Is it NUL
   terminated?  How long is it?
3) Look at sendbytes.  What length is it?  Is it longer than the size of
   buf + 8?  Is it longer than the size of inquiry_string?
4) What do we do with buf after the strncpy()?  Does the surrounding
   code assume that it is NUL terminated?  Do we copy the code to the
   user?

Once you know the answers to all these questions, then figure out which
of the questions matter in this context.  Re-write the commit message
with the relevant information.

I'm going to give you a hint here.

	rtsx_stor_set_xfer_buf(buf, scsi_bufflen(srb), srb);

This function copies "buf" to the user.

regards,
dan carpenter

