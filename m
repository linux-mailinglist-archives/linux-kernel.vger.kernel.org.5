Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9384C7C7FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjJMIPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJMIPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:15:31 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72997B8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:15:07 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6c64c2c0f97so1159136a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697184907; x=1697789707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B7XrkvxpdQNcTRb83EGgQlRqrrmQRtd14yMqKtbUE9A=;
        b=ijzCBXoPg4+nNlJw6Jqpu9oMupyVRPxSW1ExtMa7fgrK2viDgZkE8O4l1C6vLb5nsu
         uyVLnlwfD/ZoWeFuiQAFD/jeat8g2Rql8E85SfEcU5nTKGqzAp1tNOKW/3xW89CDwgRu
         VmJrD9+2YpgRhtI8miCIzolOVtVKbMF+7EUj51hU9wzRcqRlOerCj/9Cyvj1z4Zi/gme
         WjF0E2DuNdiJa+DUQaLIrm9LipLy2Wp1XZxPhZC5q7/3gPPf0jqt6+ZG9pcBcxK+1xtc
         K9KmDuUlI/JnlmtuesTx9wwy8r7vV2GzuVXpxPbz2gUWfA/+109ghHJ1w2oAkNFH9rIT
         YxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697184907; x=1697789707;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B7XrkvxpdQNcTRb83EGgQlRqrrmQRtd14yMqKtbUE9A=;
        b=VQT5vNWBN5kNWZV78ibyHF7FctD+gC2J7UXabuK8hMsitvxnOBF6d4NUsnYoFM0WZZ
         n+UiL6yg/sgJwGQyj6qP2HSuXjA7Bwr/vRmMcaodb15nvvvKk3QzSvFv6+O9jLFzebgZ
         3w3f1xkj39dfdiztTdqj3LZ0jmt9065ifYrL9kgY1qam88BdErmGRJf5AZULMiGnbd2S
         MC8qn1mm3/XMiMacmGtAEktmZQM0zH0zdKgTzMzGA+qtUii4Fgy4Ha9zxndGfcTGyiLO
         /YNs0EWLjeWoaQZfAl7ROhe8DYncUHwCbL6A79DL31f5qHwx5UVLuaFbH7jJtYOOtiBk
         mBOw==
X-Gm-Message-State: AOJu0YwEq/osYRBnpOvLXTOldhHRhhSyIPb3bBDKWeWIls+HZTwmAM3A
        DbwuIVjxBwiF7Iag5e8E6X+xgg==
X-Google-Smtp-Source: AGHT+IEmnqQcms2nEsarjh9nowrnSb+3pVJITyIyAk/J8MbpVcU1rAcnVCHRXAMLpmhoEaoTEeyJlQ==
X-Received: by 2002:a05:6870:ab13:b0:1e9:9f9b:eb76 with SMTP id gu19-20020a056870ab1300b001e99f9beb76mr6544679oab.14.1697184906630;
        Fri, 13 Oct 2023 01:15:06 -0700 (PDT)
Received: from [10.84.153.115] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id r6-20020a63b106000000b0056946623d7esm2911607pgf.55.2023.10.13.01.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 01:15:06 -0700 (PDT)
Message-ID: <00d22bc9-4abe-4e7d-9393-4025ed8c3642@bytedance.com>
Date:   Fri, 13 Oct 2023 16:14:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH 03/15] sched/fair: Add lag based placement
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
References: <20230531115839.089944915@infradead.org>
 <20230531124603.794929315@infradead.org>
 <87f1feec-1be5-4d24-a206-e30238072ae1@bytedance.com>
 <20231011132456.GO14330@noisy.programming.kicks-ass.net>
 <57c6d8c8-380e-45d9-b9d0-690662fcd6f4@bytedance.com>
 <20231013073739.GA12118@noisy.programming.kicks-ass.net>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20231013073739.GA12118@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/23 3:37 PM, Peter Zijlstra Wrote:
> On Thu, Oct 12, 2023 at 03:04:47PM +0800, Abel Wu wrote:
>> On 10/11/23 9:24 PM, Peter Zijlstra Wrote:
> 
>>>>> +		 * we should inflate the lag before placement such that the
>>>>> +		 * effective lag after placement comes out right.
>>>>> +		 *
>>>>> +		 * As such, invert the above relation for vl'_i to get the vl_i
>>>>> +		 * we need to use such that the lag after placement is the lag
>>>>> +		 * we computed before dequeue.
>>>>> +		 *
>>>>> +		 *   vl'_i = vl_i - w_i*vl_i / (W + w_i)
>>>>> +		 *         = ((W + w_i)*vl_i - w_i*vl_i) / (W + w_i)
>>>>> +		 *
>>>>> +		 *   (W + w_i)*vl'_i = (W + w_i)*vl_i - w_i*vl_i
>>>>> +		 *                   = W*vl_i
>>>>> +		 *
>>>>> +		 *   vl_i = (W + w_i)*vl'_i / W
>>>
>>> And then we obtain the scale factor: (W + w_i)/W, which is >1, right?
>>
>> Yeah, I see. But the scale factor is only for the to-be-placed entity.
>> Say there is an entity k on the tree:
>>
>> 	vl_k	= V - v_k
>>
>> adding the to-be-placed entity i affects this by:
>>
>> 	define delta := w_i*vl_i / (W + w_i)
>>
>> 	vl'_k	= V' - v_k
>> 		= V - delta - (V - vl_k)
>> 		= vl_k - delta
>>
>> hence for any entity on the tree, its lag is offsetted by @delta. So
>> I wonder if we should simply do offsetting rather than scaling.
> 
> I don't see the point, the result is the same and computing delta seems
> numerically less stable.

Right. I was not myself then, please forget what I said..
