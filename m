Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D70C7CFA4D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345757AbjJSNDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbjJSNDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:03:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4002181;
        Thu, 19 Oct 2023 06:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697720588; x=1729256588;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VgSvxH67qt9LKjm5+c5G2G8wQo6a1gXmEAilB1I2dfg=;
  b=J59FvaojU1bLb52ZkemRWNSr2TKWEa6heGKHIxtRL7pWr497hF41kZ02
   zX/nm8+i662p0+nI+A64m9GY28SrghRQhW1TEHFTHir8lrlsBAgOcCnRD
   mfylpcFwUjdw1lN7iKMDogrbOsBTBXUvC7anSeHyahCWQa7aM8MCmr7bz
   QJYWs8ra9nkm7LCYNHou7Ued6Ob4JMDHS3Q/ks/ahhleQsuSGwQ3orX5f
   9dfq7JI8qwNsGo4feX+NJKAfP0HiRJziRrvI0fIXYziRznmTerMtRJI99
   CLwXU5hO2RU9HQqI18amuJVd995IVSCZihfdt0oIhkA3kIKf6E0PU12KP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="385115720"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="385115720"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 06:01:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="757014468"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="757014468"
Received: from mttran4-mobl2.amr.corp.intel.com (HELO [10.213.160.204]) ([10.213.160.204])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 06:01:45 -0700
Message-ID: <ec25bb67-6c83-430b-bc79-234c03801250@linux.intel.com>
Date:   Wed, 18 Oct 2023 20:00:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/34] ASoC: qcom: qdsp6: Introduce USB AFE port to
 q6dsp
To:     Wesley Cheng <quic_wcheng@quicinc.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, srinivas.kandagatla@linaro.org,
        bgoswami@quicinc.com, Thinh.Nguyen@synopsys.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20231017200109.11407-1-quic_wcheng@quicinc.com>
 <20231017200109.11407-10-quic_wcheng@quicinc.com>
 <7aa4ea87-9d1f-400a-bcc5-b56e5b4500c6@linux.intel.com>
 <c72bcf47-af0b-8819-1c30-06b51358381e@quicinc.com>
 <2f05708e-3ee8-472e-a24f-6f3eb118133c@linux.intel.com>
 <fcaa93ba-3ca4-5a18-d3bd-afebe8def327@quicinc.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <fcaa93ba-3ca4-5a18-d3bd-afebe8def327@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>>>> Specifically, the QC ADSP can support all potential endpoints that are
>>>>> exposed by the audio data interface.  This includes, feedback
>>>>> endpoints
>>>>> (both implicit and explicit) as well as the isochronous (data)
>>>>> endpoints.
>>>>
>>>> implicit feedback means support for capture. This is confusing...
>>>>
>>>
>>> I mean, a USB device can expose a capture path, but as of now, we won't
>>> enable the offloading to the audio DSP for it.  However, if we're
>>> executing playback, and device does support implicit feedback, we will
>>> pass that along to the audio DSP to utilize.
>>
>> Not following. Implicit feedback means a capture stream *SHALL* be
>> started. Are you saying this capture stream is hidden and handled at the
>> DSP level only? If yes, what prevents you from exposing the capture
>> stream to userspace as well?
>>
>> I must be missing something.
>>
> 
> My understanding is that with implicit feedback endpoints, it allows for
> another data endpoint in the opposite direction to be utilized as a
> feedback endpoint (versus having to expose another EP, such as in the
> case of explicit feedback).  For example, if we are enabling the
> playback path (and the device does have a capture data ep) then the data
> ep used for the capture path can be used.

That's right, so all the plumbing is enabled for the capture path...
Making a decision to discard the data is very odd, all the work has
already been done at lower levels, so why not expose the captured data?

