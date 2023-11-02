Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841127DFBE4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 22:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377397AbjKBVHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 17:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377357AbjKBVHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 17:07:17 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8D6188
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 14:07:14 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6ce2ee17cb5so742230a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 14:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1698959234; x=1699564034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vciVZKFRXgLuRaiMsARxxONA1zdB6LDUBAvmjWlLOlg=;
        b=YgIRnWRcAt3LK7oUHBzIDpBqQ19fv6rVuxfQcpeQ2H3dA96La07DZhOgHpIScUMZl7
         ZQquhKTO1vaTas4rxEQTmbnk4lXhIDJlLJK72f2jWZw1nY4qSvvL7FMnoeFoLovvvCwJ
         YuAZcjALjbTow/cze2TEUUFjIFrcVwHL2YGBLFobhsI/3Jm9lVq3iQ5FHGuV2k41hbIB
         1xswNHuvDwu76vq7sI7XWwVsq/+s3NRivz0VGKxGjBG2vjckgIK8kYlp+SCRLToU+HGd
         bG13HzVL6ZpIB7iAYDXhDiQDxn/5sn9dhEmahblm0z5yZgAvHtRHC3jvKZL1M8Cj9s79
         uWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698959234; x=1699564034;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vciVZKFRXgLuRaiMsARxxONA1zdB6LDUBAvmjWlLOlg=;
        b=K0VskxHRdwgyWkGqpY19tLOQHlF2zRui6+YbHqzAwN/jyGHM8LkTA/U3+bzHZF2NxR
         YPGnQ5CN8eDRouc3rcLN9bEnd+U788fKjtMJElB4fi70sZSTb6ifxB6aQgtYbDHgMHHd
         wnpSDAjKXHMbYDoz2kToW8lcYTGGtinNcV36UILTGNsDors3Pi1lAF4YzRwEf6W5iIkZ
         Iupyf2yfHjmFHClaUWUnT1AYHO1E9BDAsUgnno3kyi097btftL/zJ6o1c009/NdgaiLr
         Ftgh1Gy4sp7PX1Kr34Ys1LgzddUJH+eohzHrCHIFFgdThVuNXe6WiisfsSMVL9Dxmm7E
         hI4A==
X-Gm-Message-State: AOJu0YzNGZ+bKYxLxw1RgPXo1CjrCxcwWZrOblKvuNvAwdq+Afdflqwx
        8FIwODAc0yuQc1m49roiU1QL7A==
X-Google-Smtp-Source: AGHT+IGJ4LtTPhZvlYqTcRgPejJq0L+aFGqBivEijh8ArOVIDVBIQzf3aeshyHdpd45PddiMXap4RQ==
X-Received: by 2002:a05:6830:1e87:b0:6c1:7927:6550 with SMTP id n7-20020a0568301e8700b006c179276550mr20827419otr.2.1698959233905;
        Thu, 02 Nov 2023 14:07:13 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id l14-20020a0568301d6e00b006ce1f9c62a1sm73664oti.39.2023.11.02.14.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 14:07:13 -0700 (PDT)
Date:   Thu, 02 Nov 2023 14:07:13 -0700 (PDT)
X-Google-Original-Date: Thu, 02 Nov 2023 14:07:11 PDT (-0700)
Subject:     Re: linux-next: duplicate patch in the risc-v tree
In-Reply-To: <20231103075840.02d66c1d@canb.auug.org.au>
CC:     Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <mhng-9af42db0-d787-4727-b740-80b359607c11@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Nov 2023 13:58:40 PDT (-0700), Stephen Rothwell wrote:
> Hi all,
>
> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):
>
>   e8620de3f26b ("riscv: errata: fix T-Head dcache.cva encoding")
>
> This is commit
>
>   8eb8fe67e2c8 ("riscv: errata: fix T-Head dcache.cva encoding")
>
> in Linus' tree.

Thanks, I think I got this one too -- I'd tried to pick up the feature 
on top of the fix, but I'd managed to get something wrong in the 
process.

>
> -- 
> Cheers,
> Stephen Rothwell
