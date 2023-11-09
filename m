Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FBF7E73CD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344927AbjKIVrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 16:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjKIVre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:47:34 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA7C3AA8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 13:47:31 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9e4675c7a5fso226266066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 13:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699566450; x=1700171250; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=57/MzW+inXIQgaszl6DSxcjhZsZp6Ijm+kZhgGNRRf4=;
        b=IplVbHM1zr8YSi3wo9Ns+ecnVM/mWjVOfWmQqsP5dXg9x2vQIideSPgqAhJqucYjjN
         8mXGfqRm4uZN2sKhwrQ3BRu8xRsETzNCyrqszfvxNOD+NOWZVgjeoIzhaKimHdiW6wlU
         uPul8etoM6/uTZxprB+6xNJhLZcqyzWwjSjGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699566450; x=1700171250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57/MzW+inXIQgaszl6DSxcjhZsZp6Ijm+kZhgGNRRf4=;
        b=msrwq80WCBOJ8vqIe7Xv0StuYpiRGtgJIYEVNygLFZGrvYK7m6tN75vwF7oki/0IE0
         dyPkytoJ2yuFlcx15rQDglNyoBBCJkDFlX2aZGRE7NAwqvrug7yoG6IifdNqcINpXzLz
         Lc8DwFajydtuzU1+7p3G2kJlJpcsrXtjRvX7Qfe91vNolPuV2QPolEJyrYyPL2618DJE
         qctMnbF7sUyQMKLEwDspVOXaPAKa8sn2k8z5rDBpl1vvsMlElSm7vChLx4me2qTqIUbR
         C88WcgmN8EchnbAHmuhCnu4LSLRrqi28p25aF2V6NxEELKlsDh+Cyhskv5ot2orGmvto
         KLBA==
X-Gm-Message-State: AOJu0Yx52/SKJny3Www1GutCdJj1LE3gKAxl7W7pSFuRsPvogr6xunz1
        /sHQPiK5MlDcPuRjh5We90wxocmOun3OFHVps1xl9g==
X-Google-Smtp-Source: AGHT+IFWTZiHgiy8QElhwQS34is49TfTHvUZ8VYyp+enmnsCSYnCk6VE5R8OVw/BXa7zShLBCbOCcA==
X-Received: by 2002:a17:906:6b18:b0:9e4:6d0a:c37a with SMTP id q24-20020a1709066b1800b009e46d0ac37amr3368261ejr.19.1699566449983;
        Thu, 09 Nov 2023 13:47:29 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709064f0f00b0099bcf9c2ec6sm3066251eju.75.2023.11.09.13.47.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 13:47:29 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so2323307a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 13:47:29 -0800 (PST)
X-Received: by 2002:a50:cdc4:0:b0:53e:2e74:7e0c with SMTP id
 h4-20020a50cdc4000000b0053e2e747e0cmr5745536edj.24.1699566448940; Thu, 09 Nov
 2023 13:47:28 -0800 (PST)
MIME-Version: 1.0
References: <ZUkXojmVf2CmkXHh@8bytes.org>
In-Reply-To: <ZUkXojmVf2CmkXHh@8bytes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Nov 2023 13:47:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjHyBy2Mttaj8kySJBpZ9hUiCe09ZJPo8trCRHfhi7NBg@mail.gmail.com>
Message-ID: <CAHk-=wjHyBy2Mttaj8kySJBpZ9hUiCe09ZJPo8trCRHfhi7NBg@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v6.7
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2023 at 08:43, Joerg Roedel <joro@8bytes.org> wrote:
>
> There are conflicts with the current upstream code, mainly
> from iommufd changes. My resolution is attached.

Hmm. My resolution is slightly different. In particular, in the
selftest code, I removed mock_domain_alloc() entirely in favor of
mock_domain_alloc_paging(), the same way commit 13fbceb1b8e9
("iommufd: Convert to alloc_domain_paging()") did.

That not only seems to logically match that change, it also matches
what I think Jason (cc'd) intended with commit b2b67c997bf7 ("iommufd:
Organize the mock domain alloc functions closer to Joerg's tree").

Holler if something looks odd.

                  Linus
