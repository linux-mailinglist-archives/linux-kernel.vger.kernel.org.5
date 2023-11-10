Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF7A7E76E9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345608AbjKJCAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjKJCAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:00:06 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4ABD60
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:00:04 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc2f17ab26so13314895ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 18:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1699581603; x=1700186403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8He9YqTbkF51s3BPfGK5kHNl+dAW8mFOthpsJ1/NB/g=;
        b=eAnxbr0Z6EFCvIrRxqKulygnqgp8CrBImG2KCxM/rRBPmj773HlQfRmOqjjznCNjCr
         yEAnQ0lSYDtixGojLm86GCYscCNI+IMWJSweJxVwfz00A6Kner1A7c+gAbZGSLscstue
         kM581lJIP6Dv03AoRij+QRmwaS5qdwyP1dhvep0CuO6KYi4FmyIpTVOfFrDDY3N71lpD
         +kUvrtTNe1LNmKn1zsY40EM+xz1TOYAFPiQ8BbXnmSzk8Qq27fOfxvB5hpMrAWyhQYnL
         HWDnA1DLKrNAFs3x7fBNKmsWojER2ev2Fh836RVjwmKAC4ocIdB8dQPjQ4U/8NQayPEn
         R9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699581603; x=1700186403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8He9YqTbkF51s3BPfGK5kHNl+dAW8mFOthpsJ1/NB/g=;
        b=D5NR46Yy4Sq3qIyig2CI4Id7cnfHDXHqrKbZulMnO3kKbg/pcTIgO5pPhUET2WWd1k
         uqddAAzNPFM+QDWwe6k3ORxh3EDw2Cfh1gFospHPF1IqrcFrSyauP6MML8lBrRqFRzgJ
         PgRWpbvpaCSL83bZ6ybzRe9A0V3UnEWZveuQofq/ZAs75vGEyq6BjlfuW3BJi9q4f4lV
         x5yfmrdq3ugW9cH4UREHelNHxbYErYmeo2CvkRB0BDWyU6RjFaiwNgL1OsZkP+zHGTen
         tZaO2PWlp9p7afwNUPYhrwlByh45DC61FbGg7GZrPDBXcwmyE2aY/z1ZLOuxidQaJqF9
         7JEQ==
X-Gm-Message-State: AOJu0Yzk5ycOFsDjVkvw0I6TlRVvKqLbtRAP2jTJfjoX6BTokQSbLzMd
        JAaBXXQhIDQ2t8r2OH0+xiX6IA==
X-Google-Smtp-Source: AGHT+IE4KY6yaw72j08kBhj3R5o1+nr9gUA37fKV6+VvATUxyWzWJnD5AwHpG3AcU1SsiDOnqbsJXA==
X-Received: by 2002:a17:903:2cf:b0:1cc:32df:8eb5 with SMTP id s15-20020a17090302cf00b001cc32df8eb5mr7576653plk.6.1699581603429;
        Thu, 09 Nov 2023 18:00:03 -0800 (PST)
Received: from [10.54.24.52] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b001cca8a01e68sm4169882pld.278.2023.11.09.18.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 18:00:02 -0800 (PST)
Message-ID: <99bd5dc1-18fa-4b5c-8c86-236aa976506d@shopee.com>
Date:   Fri, 10 Nov 2023 09:59:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boning: use a read-write lock in bonding_show_bonds()
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231108064641.65209-1-haifeng.xu@shopee.com>
 <ZUz/AB/kdChj5QHE@nanopsycho>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <ZUz/AB/kdChj5QHE@nanopsycho>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/9 23:47, Jiri Pirko wrote:
> 
> s/boning/bonding/
> ?

Yes, Eric has pointed out the problem in last email.
Thanks.
