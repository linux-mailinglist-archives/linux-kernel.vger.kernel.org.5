Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC077FE8FD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 07:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbjK3GKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 01:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjK3GKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 01:10:04 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A240910C9;
        Wed, 29 Nov 2023 22:10:10 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6cda22140f2so563484b3a.1;
        Wed, 29 Nov 2023 22:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701324610; x=1701929410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B1if+FaxPFsagkd6FaxS0qG7gZ8HWUvLobcB5yNd8/Y=;
        b=h+bv/rtfYz1UiS++vM1Xl73aXpbuieUpcdSWnFeJGOizuFAb4hsQT35p0VALTcb1Km
         viGDPIwOeZ8k4QZjbDBpvpEc1uZFm59q8HNd3YrLj8QpKAfrKXLWQKU6Lr5xW8STdcGp
         YE13MSQVSplTF76oTV8Z99qTgES9Q+7HbAHnZvNuaOcjNZj2GsE01AvALcNUGvn5nn3D
         uKE2Monw8XWffSe0d6umWFBAWIPKFGyhS48olxEbLRMM0IW3uDjtKMlkAwFEC1NOxspg
         EMdakBELr48F2/PwDa1Iys2uJQGqQ9stvpz2uHUeCrUvpNJncYn5LbrNJBXfg0ELSaYE
         XJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701324610; x=1701929410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1if+FaxPFsagkd6FaxS0qG7gZ8HWUvLobcB5yNd8/Y=;
        b=dMovQYSqnEx+GLfcM0OkOee42103QdhUMoeYeX+bH/5Cv8GBAPvwDTsRTYEogoxq3D
         aD2E93QiTfU6WPJPknq3ots+acX1Q7+Bf30owHFJ6S/j8xSQfMVX98dx1ZYTiZbU0bVi
         1FdjdErgjTOwhlfO548X/DYdag/TuJUO1r7jECEbVeygi9bd0pJNxA9ZXcxFCGhsv/tD
         IAPAzBTpnVvB/9WNyZPvOzbnaGWOFL6TZFNYtx60DQRbrAbugBf51PFSDQCGfqvPBdQX
         lBC9VmekkF+jfhbXNgDdbglRB6ggS/+3A4+UiTRBNOs2SnmJNLF14AIq+MXhQ0Bg/2lB
         CiLQ==
X-Gm-Message-State: AOJu0Yxgt+s9FPev+ck/5TFKEXM9OMAONDPeTWECmiYGLK/1xuLwlyIT
        Su3pLUqK7N7XeSXLyKkyZwQ=
X-Google-Smtp-Source: AGHT+IGSpgI7z/zJoecmKlbsF3awMHC/e9Nfm/pF6FwG2Z3jnVudDFlFtY97wBlTwMfcyf2RlcRKCA==
X-Received: by 2002:a05:6a20:3d11:b0:18c:9855:e949 with SMTP id y17-20020a056a203d1100b0018c9855e949mr14197707pzi.15.1701324609919;
        Wed, 29 Nov 2023 22:10:09 -0800 (PST)
Received: from [192.168.255.10] ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id w1-20020a636201000000b005b32d6b4f2fsm442926pgb.81.2023.11.29.22.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 22:10:09 -0800 (PST)
Message-ID: <049e4892-fae8-4a1d-a069-70b0bf5ee755@gmail.com>
Date:   Thu, 30 Nov 2023 14:10:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86/xsave: Remove 'return void' expression for 'void
 function'
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
References: <20231007064019.17472-1-likexu@tencent.com>
 <e4d6c6a5030f49f44febf99ba4c7040938c3c483.camel@redhat.com>
 <53d7caba-8b00-42ab-849a-d8c8d94aea37@gmail.com>
 <ZTklnN2I3gYjGxVv@google.com> <ZTm8dH1GQ3vQtQua@google.com>
Content-Language: en-US
From:   Like Xu <like.xu.linux@gmail.com>
In-Reply-To: <ZTm8dH1GQ3vQtQua@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 26/10/2023 9:10 am, Sean Christopherson wrote:
> On Wed, Oct 25, 2023, Sean Christopherson wrote:
>> On Wed, Oct 25, 2023, Like Xu wrote:
>>> Emm, did we miss this little fix ?
>>
>> No, I have it earmarked, it's just not a priority because it doesn't truly fix
>> anything.  Though I suppose it probably makes to apply it for 6.8, waiting one
>> more day to send PULL requests to Paolo isn't a problem.
> 
> Heh, when I tried to apply this I got reminded of why I held it for later.  I
> want to apply it to kvm-x86/misc, but that's based on ~6.6-rc2 (plus a few KVM
> patches), i.e. doesn't have the "buggy" commit.  I don't want to rebase "misc",
> nor do I want to create a branch and PULL request for a single trivial commit.
> 
> So for logistical reasons, I'm not going apply this right away, but I will make
> sure it gets into v6.7.

Thanks, and a similar pattern occurs with these functions:

  'write_register_operand'
  'account_shadowed'
  'unaccount_shadowed'
  'mtrr_lookup_fixed_next'
  'pre_svm_run'
  'svm_vcpu_deliver_sipi_vector'

Although the compiler will do the right thing, use 'return void' expression
deliberately without grounds for exemption may annoy some CI pipelines.

If you need more cleanup or a new version to cover all these cases above,
just let me know.
