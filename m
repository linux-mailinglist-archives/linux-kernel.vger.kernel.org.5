Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709407A12D5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 03:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjIOBQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 21:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjIOBQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 21:16:57 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB45268E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 18:16:52 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso220192566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 18:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1694740611; x=1695345411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NPhAEJforhjWZp+uVyQ1+GyAsVZzUl1B486vJg9MvnA=;
        b=qc0HR92ns3kwOlSuTfQ7vELR7rhC1HJlvaiK5pD+E6oVGzbyAlJiA0zsQdgHhwGogh
         esNR9ivv7SCtib/rLWOICnDa7LdUDc350eNd+Ao/CRMGSl07p7GxmiX/QXgA2U5kt4az
         XxkHPUMa9rK1jBT9jMGI22o6tVMLecG+UR4K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694740611; x=1695345411;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPhAEJforhjWZp+uVyQ1+GyAsVZzUl1B486vJg9MvnA=;
        b=sZUjBqCr7licz4gFhk7GH0fVuFANUcRLE72HzGD2KXLnspY40iR9r2vwpPjdva91zW
         B4vYLPe4yN5tQo3idFaOxWRijUB6eb8xKGlY0QzI9j7/QPe7fGvQ/CZ8bI6uYKcXF8Dp
         6VVwZu+oRGXIO8+jB1Yuj47EwaEo6DQB+NJy2yjIjYMfUaZcFs9kpGzrLUuGwEOfDEKT
         erQK2c7Q9+FSpF6dcZkHRvx/BKQY0bAMbZ6U0OHTAt8g1tFh3v8+nZuk4KELMfoE/ajX
         iYL+jBpObh90xngIIDmfujb6bnOneufVwpkiLJodrgFJy/k2xItL9lZemhqvHOq9XtGZ
         oBWg==
X-Gm-Message-State: AOJu0Yz6C79JO87sB0kFCxPnr424kYcmm+7yWuU2JR0GUQu4InLwg1HV
        /n7AsWfita9L4g7iKEmcv+QZ0w==
X-Google-Smtp-Source: AGHT+IE7O+PeUxB72+aWKd2SThAEBmIs9sfrCItn5Ff0aKMedVWukOd31H6m4Ef8LNnP3BDRvPbAaw==
X-Received: by 2002:a17:906:3f49:b0:99c:56d1:7c71 with SMTP id f9-20020a1709063f4900b0099c56d17c71mr118141ejj.26.1694740611206;
        Thu, 14 Sep 2023 18:16:51 -0700 (PDT)
Received: from [192.168.1.10] (host-92-12-44-130.as13285.net. [92.12.44.130])
        by smtp.gmail.com with ESMTPSA id v7-20020a1709064e8700b00977cad140a8sm1674597eju.218.2023.09.14.18.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 18:16:51 -0700 (PDT)
Message-ID: <6575702e-fea5-61b2-dd61-7b556a8603e8@citrix.com>
Date:   Fri, 15 Sep 2023 02:16:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   andrew.cooper3@citrix.com
Subject: Re: [PATCH v10 03/38] x86/msr: Add the WRMSRNS instruction support
Content-Language: en-GB
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Xin Li <xin3.li@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, luto@kernel.org, pbonzini@redhat.com,
        seanjc@google.com, peterz@infradead.org, jgross@suse.com,
        ravi.v.shankar@intel.com, mhiramat@kernel.org,
        jiangshanlai@gmail.com
References: <20230914044805.301390-1-xin3.li@intel.com>
 <20230914044805.301390-4-xin3.li@intel.com>
 <6f5678ff-f8b1-9ada-c8c7-f32cfb77263a@citrix.com> <87y1h81ht4.ffs@tglx>
 <7ba4ae3e-f75d-66a8-7669-b6eb17c1aa1c@citrix.com>
 <0e7d37db-e1af-ac40-6eca-5565d1bebcde@zytor.com>
In-Reply-To: <0e7d37db-e1af-ac40-6eca-5565d1bebcde@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 2:01 am, H. Peter Anvin wrote:
> The whole bit with alternatives and pvops being separate is a major
> maintainability problem, and honestly it never made any sense in the
> first place. Never have two mechanisms to do one job; it makes it
> harder to grok their interactions.

This bit is easy.

Juergen has already done the work to delete one of these two patching
mechanisms and replace it with the other.

https://lore.kernel.org/lkml/a32e211f-4add-4fb2-9e5a-480ae9b9bbf2@suse.com/

Unfortunately, it's only collecting pings and tumbleweeds.

~Andrew
