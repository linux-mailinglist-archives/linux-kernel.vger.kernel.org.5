Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3903A766542
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbjG1H0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbjG1HZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:25:52 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0903C00
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690529149; x=1722065149;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jcImtnLwcUfLeQIU1OvOi7H26D0RUYzhnoSlDqyoMtY=;
  b=Omx35K32QcZBr2IoaMUt3SE0euQWtwdHO5Ba5Z9LNbF3JZ90hAIfL7jG
   zq554d7pooJcoeIJEQ+5vKRPZwRUnRDow741/vjN1PDJ8Tt2uWRPv7uv3
   5wzfo4ILQNXUG36mRCNapXVQxILYHSIXlzC+3LMI8fzKb0EKVVnQ0p6ki
   0S7gDXYrGqmdF63X0uLprZBpVFAW9YEwDyO/Dd04l0ZwuiNQGIiUE4Zzc
   cfQzRl0McMU1VGt917GlEQElLTPgagNEtuSXBOkuV6qO1KEIdytBBgwZl
   f1CQRIXokjtDwCmqRl27a8Bkej5xM0ejHStC/8uPzbYPbN0zro4IHxXh2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="353434718"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="353434718"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 00:25:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="973949477"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="973949477"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 00:25:27 -0700
Message-ID: <402a7a63-5584-ef79-e42f-e2102f42b9aa@linux.intel.com>
Date:   Fri, 28 Jul 2023 09:25:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ASoC: Intel: Skylake: replace deprecated strncpy with
 strscpy
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, justinstitt@google.com
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nathan Chancellor <nathan@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20230726-asoc-intel-skylake-remove-deprecated-strncpy-v1-1-020e04184c7d@google.com>
 <202307261532.3EFCF04F1@keescook>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <202307261532.3EFCF04F1@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/2023 12:34 AM, Kees Cook wrote:
> On Wed, Jul 26, 2023 at 09:12:18PM +0000, justinstitt@google.com wrote:
>> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
>>
>> A suitable replacement is `strscpy` [2] due to the fact that it
>> guarantees NUL-termination on its destination buffer argument which is
>> _not_ the case for `strncpy`!
>>
>> It was pretty difficult, in this case, to try and figure out whether or
>> not the destination buffer was zero-initialized. If it is and this
>> behavior is relied on then perhaps `strscpy_pad` is the preferred
>> option here.
>>
>> Kees was able to help me out and identify the following code snippet
>> which seems to show that the destination buffer is zero-initialized.
>>
>> |       skl = devm_kzalloc(&pci->dev, sizeof(*skl), GFP_KERNEL);
>>
>> With this information, I opted for `strscpy` since padding is seemingly
>> not required.
> 
> We did notice that str_elem->string is 44 bytes, but
> skl->lib_info[ref_count].name is 128 bytes. If str_elem->string isn't
> NUL-terminated, this can still hit an over-read condition (though
> CONFIG_FORTIFY_SOURCE would have caught it both before with strncpy()
> and now with strscpy()). So I assume it is expected to be
> NUL-terminated?
> 

Yes it is a filename of additional library which can be loaded, topology 
UAPI only allows for passing 44 bytes long strings per string token (see 
snd_soc_tplg_vendor_array -> union -> string flex array -> 
snd_soc_tplg_vendor_string_elem -> SNDRV_CTL_ELEM_ID_NAME_MAXLEN), so we 
could also change length of
skl->lib_info[ref_count].name and potentially save few bytes. And 
looking at it again I also think that we should not copy destination 
size number of bytes, by which I mean 
ARRAY_SIZE(skl->lib_info[ref_count].name), which is 128 in this case... 
so either need to change destination buffer size to be same as topology 
field or calculate it differently.


