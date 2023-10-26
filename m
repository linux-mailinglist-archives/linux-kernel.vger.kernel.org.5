Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5997D7C29
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjJZFZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjJZFZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:25:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5B0DE
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=264fWZxxGW0DECTaVAjBqKdK5xaDEeBQUM+BQhVJXr8=; b=bPcJdpIIRjy9nbG0xYgLhFYaKc
        E7Kwik4J0iRTYo2zaHoFt+mjojzBkRX3xn9HWrtIkGlgX7F8jQbP+rXdbERNhPUZtDvVgzXfa9j4t
        XjSTYZpMP5XghxXMxgpG2gP4nuDGos5rL94dWtTqMlrrcRLaJCmcYlh57HE4JoN1i1vOZ9S2XZqd+
        PEEe7lf7gZFXvep0xNdNOF3v8fKi3UWWSB31Txls96MS//ZegmOE5RIxnCEWUVv2TLYp/Gjbkwu65
        goOzl2KYpQIhpg4cZL3FUNH/CpNCoJQX9oAOedPsjaxzHgZ6rMrJzlpYYWTp37+vYcHNHTH/ngjFR
        GQAAOAvg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qvss3-00Dh6y-0m;
        Thu, 26 Oct 2023 05:25:27 +0000
Message-ID: <8ed89012-9018-473c-9007-8c34bbb57bcf@infradead.org>
Date:   Wed, 25 Oct 2023 22:25:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel/user_namespace.c:239: warning: Function parameter or
 member 'map_up' not described in 'idmap_key'
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <202308172003.O1QB7TgB-lkp@intel.com>
 <9a05d92f-60c5-6ede-2105-829f09c737b7@infradead.org>
 <20230830-koiteich-ehrerbietung-8191852e752b@brauner>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230830-koiteich-ehrerbietung-8191852e752b@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/23 01:24, Christian Brauner wrote:
> On Mon, Aug 28, 2023 at 10:13:06PM -0700, Randy Dunlap wrote:
>> Hi Christian,
>>
>> On 8/17/23 05:56, kernel test robot wrote:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
>>> commit: e227db4d4f125efb1cae2f1337da85bc10b3185e userns: fix a struct's kernel-doc notation
>>> date:   7 months ago
>>> config: parisc64-defconfig (https://download.01.org/0day-ci/archive/20230817/202308172003.O1QB7TgB-lkp@intel.com/config)
>>> compiler: hppa64-linux-gcc (GCC) 12.3.0
>>> reproduce: (https://download.01.org/0day-ci/archive/20230817/202308172003.O1QB7TgB-lkp@intel.com/reproduce)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202308172003.O1QB7TgB-lkp@intel.com/
>>>
>>> All warnings (new ones prefixed by >>):
>>>
>>>>> kernel/user_namespace.c:239: warning: Function parameter or member 'map_up' not described in 'idmap_key'
>>>>> kernel/user_namespace.c:239: warning: Function parameter or member 'id' not described in 'idmap_key'
>>>>> kernel/user_namespace.c:239: warning: Function parameter or member 'count' not described in 'idmap_key'
>>>    kernel/user_namespace.c:246: warning: Function parameter or member 'k' not described in 'cmp_map_id'
>>>    kernel/user_namespace.c:246: warning: Function parameter or member 'e' not described in 'cmp_map_id'
>>>    kernel/user_namespace.c:277: warning: Function parameter or member 'extents' not described in 'map_id_range_down_max'
>>>    kernel/user_namespace.c:277: warning: Function parameter or member 'map' not described in 'map_id_range_down_max'
>>>    kernel/user_namespace.c:277: warning: Function parameter or member 'id' not described in 'map_id_range_down_max'
>>>    kernel/user_namespace.c:277: warning: Function parameter or member 'count' not described in 'map_id_range_down_max'
>>>    kernel/user_namespace.c:295: warning: Function parameter or member 'extents' not described in 'map_id_range_down_base'
>>>    kernel/user_namespace.c:295: warning: Function parameter or member 'map' not described in 'map_id_range_down_base'
>>>    kernel/user_namespace.c:295: warning: Function parameter or member 'id' not described in 'map_id_range_down_base'
>>>    kernel/user_namespace.c:295: warning: Function parameter or member 'count' not described in 'map_id_range_down_base'
>>>    kernel/user_namespace.c:344: warning: Function parameter or member 'extents' not described in 'map_id_up_base'
>>>    kernel/user_namespace.c:344: warning: Function parameter or member 'map' not described in 'map_id_up_base'
>>>    kernel/user_namespace.c:344: warning: Function parameter or member 'id' not described in 'map_id_up_base'
>>>    kernel/user_namespace.c:364: warning: Function parameter or member 'extents' not described in 'map_id_up_max'
>>>    kernel/user_namespace.c:364: warning: Function parameter or member 'map' not described in 'map_id_up_max'
>>>    kernel/user_namespace.c:364: warning: Function parameter or member 'id' not described in 'map_id_up_max'
>>>    kernel/user_namespace.c:776: warning: Function parameter or member 'map' not described in 'insert_extent'
>>>    kernel/user_namespace.c:776: warning: Function parameter or member 'extent' not described in 'insert_extent'
>>>    kernel/user_namespace.c:844: warning: Function parameter or member 'map' not described in 'sort_idmaps'
>>>
>>
>> According to 'git blame', all of these come from additions that you made.
>>
>> What do you think about a patch that converts all of these into non-kernel-doc comments?
>> I.e., change "/**" to "/*" for the functions and struct?
> 
> Yeah, sure.

Hi Christian,

I sent a patch for this on 2023-AUG-30:

https://lore.kernel.org/all/20230830163215.13193-1-rdunlap@infradead.org/


-- 
~Randy
