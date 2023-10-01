Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3FC7B4772
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 14:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbjJAMbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 08:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbjJAMbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 08:31:42 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4908AC
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 05:31:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-405361bba99so154574665e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 05:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696163497; x=1696768297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qggYyBI2MmZAf88d9GZUthMKLpUVPx7w2Ym0e8c+iTg=;
        b=ii4zLFRmNpHbeqTUc+Bx1aRvZ2W9DJXy3CM5TuefWY2167sEmnWwfetSISJn9rxnJm
         QbKaesam5tZD2MEYdBHZ+sWGQfgidXuXC4k/2FKPdjY5A5ggYJeGtJm+g/5RwI9QUEWR
         IYHGDditFt+TR2Z7ghzCYmC3GBpN3p/v38jcZNp7oe7auZSlktEl267SDqaOXVdn0evF
         XY3KZtgFoMHIpJcS51ddRpgiU6uEiFWuOTp3ZtDfNton41GroMqu6R3drigjvatvpBaJ
         OiFil1RLtxJB2EkA76QWIPB5BzeJ2Rv2MUpiv6n4pzuzM3XD/WPlnDRR2cqy3ek67oL5
         Du1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696163497; x=1696768297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qggYyBI2MmZAf88d9GZUthMKLpUVPx7w2Ym0e8c+iTg=;
        b=QslBnB1mjHEdHAgOXlHInTd/5NoAVLFS/YOLxeyg6F7+KeclyhnCxeNxr8Z4DIYhEv
         pBylJulf+Xa+L819h8QxxI72GBsnr8NkWNFD4KE18UMHh3qQ2SorXTAui6Hx/qGg7TAf
         eOKKChM1ysqI+qy7yuFi8QB5mqAm3nCpKwwh4pDdbgcT1elm3FpxnZOheforxEV5aqmA
         xfuO84Kn8/gKL3dG8RZRVoaoI9DR+u7WYC4C8KuPfZhwhWQ/W9W6oPeoSkVfJGWTN4WC
         z77FlI7i5WyzS6Gt3n82isjxrnScagFQuhlkV6To4DdL1elDKRqvzmQV4nyns++ce1tF
         sLzQ==
X-Gm-Message-State: AOJu0YzgFmvvk2dqelcj+IscPFMXhGpKuwE76w6XOqJQVttc5fpb5+Ou
        4dDdCKGWMHTaUuz4rlRJEgU=
X-Google-Smtp-Source: AGHT+IHXTsAjwmpBL1BW18qklz/uXDp7ROcowKnLevFUGElkQG/sxRDfgMKKoiNsSdma6THQqF6RoA==
X-Received: by 2002:a7b:c456:0:b0:3fe:d71a:d84e with SMTP id l22-20020a7bc456000000b003fed71ad84emr7668788wmi.1.1696163496973;
        Sun, 01 Oct 2023 05:31:36 -0700 (PDT)
Received: from gmail.com (84-236-113-123.pool.digikabel.hu. [84.236.113.123])
        by smtp.gmail.com with ESMTPSA id y24-20020a05600c365800b0040652e8ca13sm5176146wmq.43.2023.10.01.05.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 05:31:34 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 1 Oct 2023 14:31:32 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alexey Kardashevskiy <aik@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH kernel v2] x86/compressed/64: reduce #VC nesting for
 intercepted CPUID for SEV-SNP guest
Message-ID: <ZRlmpFFiYdlC7YQq@gmail.com>
References: <20230926040526.957240-1-aik@amd.com>
 <20230930071759.GAZRfLpz38AAITSZzW@fat_crate.local>
 <e009f70e-32fc-404a-8560-f059b8999895@amd.com>
 <20231001095322.GAZRlBkle6JC2rfM6u@fat_crate.local>
 <ZRljbqRbaj+eoUU6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRljbqRbaj+eoUU6@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> But I'm fine with both approaches, I suggested a macro because the
> existing rdtsc definitions used macros already - but I have no
           ^---- rdmsr
