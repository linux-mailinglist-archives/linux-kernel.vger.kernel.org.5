Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22D376F083
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbjHCRVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjHCRVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:21:14 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870462D65
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 10:21:13 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a3df1ee4a3so751481b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 10:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1691083273; x=1691688073;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lHdWNd7NcxIk3qmFO2a77DMoqeY4hXR/sOoF4ciAHOQ=;
        b=u/1k5qObBVCl38/3CowQvVgypngd3K1HPJMlDnoQ6QtMtPiP3m3H/2eH+E4S3AG2BU
         F7A9YcqRvxkoV3qvqyc6RRe7lCWCq5dgrM5jf5mJJioLwHv7VZ+fJN7le2jVVBOl0L14
         1zUyZrjKsu5GMwlV/cVvm37GBXQ2Hkj4nPFulaNypdKHHTjqmJkeToq4JeXZ0qe7h6dH
         JQn6NB1zjbbbTmfMnuLFeCN14X26BxH1JXKNIicrRghk8IpJcr+8xM45xpWWLHfug32m
         EVLQDkwsHya09x1PU6t1tONJlqE5MArvrfKFLXPi9V8hjHAx/nDGQGMqQfq2zbh7lav/
         lDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691083273; x=1691688073;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lHdWNd7NcxIk3qmFO2a77DMoqeY4hXR/sOoF4ciAHOQ=;
        b=ijj+mRMfMS7kWM0otEHy/8xfCqU471d1Uy4rOTVH3DlLvHLLFUPhk36ZyAcX+PiBNG
         V/SKK55WmYwuQ8E94k7KBpih71DJDFJz0fpKeB1htr/ipoxPKkuWypLBPWyn5DeHCWBt
         b4iRzOV7rrwTcyWuZDuvay4AMhiFdwLuulm06UMcWVcUJENabNsbVQQOqDe5aE/+ardV
         1JqjrANjY72u8tSIa8ly1T6htNIntDtawkjJh7FRCZd6RuXcOlMjeCOGe5epUPr+NUpO
         ccZc+89XjJ7RlrPwzEQ4VSCNqsq+xN34XUicCEZM/1CfzRpCa1JdQN2hNGrP2PEvt61L
         TWFQ==
X-Gm-Message-State: ABy/qLav9wRnzMVRWct563pQ4VreEIPstfT6ipZDw9fL9giXWeKt115L
        YHfFkm+4UiW2jQxiuLU+ldG/Sg==
X-Google-Smtp-Source: APBJJlGH0lg4xAj9gNoRvacMhdgLpvXIeQDJkix5j8dz6wOxOx3nhnV4WJeq1As92cXHB5U1ImSKeA==
X-Received: by 2002:a05:6870:d7a6:b0:1b0:e98:163b with SMTP id bd38-20020a056870d7a600b001b00e98163bmr18685097oab.21.1691083272712;
        Thu, 03 Aug 2023 10:21:12 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c1:9170:5736:6909:750b:c9a8? ([2804:7f1:e2c1:9170:5736:6909:750b:c9a8])
        by smtp.gmail.com with ESMTPSA id v17-20020a056870955100b001bee99e97a9sm185013oal.43.2023.08.03.10.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 10:21:12 -0700 (PDT)
Message-ID: <918bf9fc-1c8f-a006-560e-b437581c6ec2@mojatatu.com>
Date:   Thu, 3 Aug 2023 14:21:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 net-next 09/10] selftests/tc-testing: test that taprio
 can only be attached as root
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Maxim Georgiev <glipus@gmail.com>
References: <20230801182421.1997560-1-vladimir.oltean@nxp.com>
 <20230801182421.1997560-10-vladimir.oltean@nxp.com>
From:   Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20230801182421.1997560-10-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2023 15:24, Vladimir Oltean wrote:
> Check that the "Can only be attached as root qdisc" error message from
> taprio is effective by attempting to attach it to a class of another
> taprio qdisc. That operation should fail.
> 
> In the bug that was squashed by change "net/sched: taprio: try again to
> report q->qdiscs[] to qdisc_leaf()", grafting a child taprio to a root
> software taprio would be misinterpreted as a change() to the root
> taprio. Catch this by looking at whether the base-time of the root
> taprio has changed to follow the base-time of the child taprio,
> something which should have absolutely never happened assuming correct
> semantics.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
If I understood correctly, these tests depend on CONFIG_PTP_1588_CLOCK_MOCK.
If that is the case, you should add it to the tdc
config file (tools/testing/selftests/tc-testing/config).

cheers,
Victor
