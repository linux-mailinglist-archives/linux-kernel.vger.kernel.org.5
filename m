Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B66A7EE9FE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 00:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjKPXeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 18:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKPXes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 18:34:48 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7A793;
        Thu, 16 Nov 2023 15:34:45 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6bb4abb8100so1299676b3a.2;
        Thu, 16 Nov 2023 15:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700177685; x=1700782485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jIlDZqCcqHIUeo2ZFPIfybYwe4tkogvnCJH8Ch20WTY=;
        b=Ahnelm3edpAG0whrXJ0FifJkHMQRe5Qre9UFL4Vz7HwP/A8ftJSJnfIjWpU4rRhD8s
         TrRtfPFe56cpWNSh6DWSePV1CfHZAvFu9/jYMRv3Sks7ISjoaP2hEwrkTkCEVZ5eEN6C
         jCWOwzlvt4VdFkAScPazLLY2q1T0pT3rk3DrlqFKL2sM+Kx8FIFgLUNnIkC6gC5OGMF8
         7LfQ8VWp4QSCqLhoqt8ic/G78bBbQYL+J0JZ1l7hxTz0CdCTNyntuVTU+FxemAfYxfP0
         VLXXS+AIq01n2FLd8Au/IBVwVdouT5EEHYxYFUfhsZS8h9ZzU+YTaNyBK7JpCHvEyAUt
         AdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700177685; x=1700782485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIlDZqCcqHIUeo2ZFPIfybYwe4tkogvnCJH8Ch20WTY=;
        b=fl1eZs5u0IrOM2R8JG8/hp2jnP85L5r+IlKNxFpWeRavTTa4UL9hxDIZaJEIM1dGV9
         SvwtuX6AcEQG3n0HJZ0+lJE/SjaPPH5JIlYUQXHngW2lmIYnS3kTGfWVRpglvMGyH2YW
         wYRRArYR6wsOTs5qra9Tux/xO+GRh6lt8TpbXRUBoOJD+kWJbabab7Hlm8U+aqqSlNqj
         z3X1CN8Fft3ZWU7NS5eYY2dX+x7QztUBEWLqSZe6242NwujNUYe0SrlqwuiBIAwqtaiH
         uEe3QyU4inBIeiNbEbSgD7vUIGzbn6BNtHdRFGHcpTn0Qelm/88P5bu3i/mUvz+bZtIr
         grwg==
X-Gm-Message-State: AOJu0YzKPj0Gvjyr8rSFu6d/CUHQdzT3nHfAOXR+Mib+X60nPuxC1/Mi
        vGlSJZflorKxCuB2LXeKmwYpNbcOXetYdA==
X-Google-Smtp-Source: AGHT+IHQSlFjtHHnifyRR+5Low3mKJhBkumS/gS7LHof04DGhzo/G17nSkrxx0T/ja/Xt7XWz9cavQ==
X-Received: by 2002:a05:6a20:3942:b0:187:d5e8:5709 with SMTP id r2-20020a056a20394200b00187d5e85709mr2649587pzg.4.1700177685029;
        Thu, 16 Nov 2023 15:34:45 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id e7-20020a631e07000000b0056b6d1ac949sm252545pge.13.2023.11.16.15.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 15:34:44 -0800 (PST)
Message-ID: <a75ce6e7-5012-43d8-a222-dd2639c5969c@gmail.com>
Date:   Fri, 17 Nov 2023 06:34:39 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: acp3x: Missing product ID for Thinkpad T14s Gen2 AMD Ryzen 7
 PRO 5850U
Content-Language: en-US
To:     Oliver Sieber <ollisieber@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Sound System <linux-sound@vger.kernel.org>,
        Linux ALSA Development <alsa-devel@alsa-project.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <8bd0e77f-720b-4804-bbd8-477bd7df938e@gmail.com>
 <251c1bea-8250-40dd-bdea-1cd739d1e77a@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <251c1bea-8250-40dd-bdea-1cd739d1e77a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/23 01:36, Oliver Sieber wrote:
> Hi,
> 
> thanks for your fast answer. I added my proposed patch as attachment.
> 
> Please be aware that this is my first kernel patch.
> 

Please don't top-post; reply inline with appropriate context instead.

Your patch is attached, please send it inline instead. See
Documentation/process/submitting-patches.rst for how to do that.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

