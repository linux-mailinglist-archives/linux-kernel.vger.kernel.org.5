Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7006D7EEAAE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 02:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjKQB13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 20:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjKQB11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 20:27:27 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0004C129
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 17:27:20 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1f573a9ed69so795431fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 17:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700184440; x=1700789240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aKf/LZV/kvSMDigtlOXJdd990tp8RAjm519fFm7u9Sc=;
        b=XvbhMbyotVUY7kSB4pm2wrtlQnw9iGsTbTgHT3tu92ZOA8QmwwlgRVtV1DBB2IAHll
         tnMHrs7fck9cNJB7ePEo7xvAnsiQMHQFAUN3njz+CwTd2uYfMAuxTvOJHfKE/elR7VNU
         caJD7CN+zD8uFSJolo8EPV6/4E63D49upO7l1bHy9+AkUQ6wR3x24gOuVwTS61yjt4aE
         EKPaz7pMnghMLvJ68YHHr+rhelx2y6O0JIZKnsjiwJU8PLl+ZtkrFtUNBrHfi8K+A20i
         3h099f7fexEaKe5jORKvYM+sR2c2ZHO8H/3juip2p42lXhAq4IQcg51yJDdfuRRD7r/v
         G1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700184440; x=1700789240;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKf/LZV/kvSMDigtlOXJdd990tp8RAjm519fFm7u9Sc=;
        b=Zh9JOC6o+ByEmtjzLoXt34tDUOpQgg0abqi+bHxdsRZsuqoXWE3zKchBHf4n/VdJHt
         bR5ZQZfm8c7PZROXyCwJW/p6Bq0YCtVOidnGvYCT1+2vQQF1ffqSC50N/wcErgnK/WEU
         CHUF/KB0KOfISO2F9J0EJMqhAs8upotvP7Q31yLGmzG4k+pX8s9w8B05/A5NsbciwHfD
         qARo++ImeHs+oqAGVJpha5YAWGBxcdv2vIryyFat/+tpIt31FpJHOF4aRKUBRjezEBva
         71p1P88LMaDDSrqLqbakFV/aWbXehmEcOc3hnMSGUhb5eK1GCMJ0tH9bJviaDYoM5hhH
         FTrg==
X-Gm-Message-State: AOJu0YxoVtAKQbZcbkNoOcZTDgavAVcHcY02+18kxAREnP0BK7IogJye
        avXo4xbOwaLkrMOwTclGkefs8g==
X-Google-Smtp-Source: AGHT+IHe+gWJw0AKxuVcbBIXwt32o0SzEtp1hkMypo+gLCWDCnHgrd9UcktssVj7AN6A8lUEGQalJA==
X-Received: by 2002:a05:6870:d210:b0:1f0:630c:a58a with SMTP id g16-20020a056870d21000b001f0630ca58amr21197727oac.51.1700184440236;
        Thu, 16 Nov 2023 17:27:20 -0800 (PST)
Received: from ?IPV6:2804:14d:5c5e:44fb:7741:c354:44be:5c3f? ([2804:14d:5c5e:44fb:7741:c354:44be:5c3f])
        by smtp.gmail.com with ESMTPSA id y19-20020a056a00191300b0069ee4242f89sm372131pfi.13.2023.11.16.17.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 17:27:19 -0800 (PST)
Message-ID: <8c0bc61e-c0f1-49d8-8696-812c336fb74b@mojatatu.com>
Date:   Thu, 16 Nov 2023 22:27:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [selftests/tc] d227cc0b1e:
 kernel-selftests.tc-testing.tdc.sh.fail
From:   Pedro Tammela <pctammela@mojatatu.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Davide Caratti <dcaratti@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
References: <202311161129.3b45ed53-oliver.sang@intel.com>
 <f9f772dd-5708-4823-9a7f-20ae8536b5e5@mojatatu.com>
Content-Language: en-US
In-Reply-To: <f9f772dd-5708-4823-9a7f-20ae8536b5e5@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2023 11:16, Pedro Tammela wrote:
> On 16/11/2023 03:42, kernel test robot wrote:
>> [...]
> 
> Hi!
> Thanks for the report.
> I'm trying to address this issue and others in this series:
> [PATCH net-next 0/4] selftests: tc-testing: updates to tdc
> 
> I have seen this timeout in other CIs as well, but I cannot reproduce 
> locally, even with the CI build running on my laptop. I did notice in my 
> local tests that KVM is a big factor for test completion, so it begs the 
> question, is it running on a KVM enabled instance?
> 
> If there's any document describing the runner instances I would be 
> interested too.

OK, I was finally able to reproduce the timeout.
I have some fixes prepared, will post them tomorrow after more testing!
