Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC587A2475
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbjIORRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbjIORQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:16:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAFA883
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:16:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE8EC1FB;
        Fri, 15 Sep 2023 10:17:23 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F08143F5A1;
        Fri, 15 Sep 2023 10:16:44 -0700 (PDT)
Message-ID: <6682c765-9d7f-dd21-af85-e83cee435a89@arm.com>
Date:   Fri, 15 Sep 2023 18:16:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXT] Re: resctrl2 - status
Content-Language: en-GB
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Amit Singh Tomar <amitsinght@marvell.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        George Cherian <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "peternewman@google.com" <peternewman@google.com>,
        Drew Fustini <dfustini@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <DS7PR11MB6077FE180B11A9138D8E7ED7FC1DA@DS7PR11MB6077.namprd11.prod.outlook.com>
 <35f05064-a412-ad29-5352-277fb147bbc4@intel.com>
 <SJ1PR11MB6083BC6B330FA7B7DFD3E76AFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <dc4cd365-2a02-32a3-da78-7ba745877e97@intel.com>
 <SJ1PR11MB6083C0ED50E9B644F4AF8E4BFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <fb9499b9-c445-01e8-8427-6b05256abdb5@intel.com>
 <20230829112321.00002b55@Huawei.com>
 <MW4PR18MB50847485155B226B07DABEAAC6E7A@MW4PR18MB5084.namprd18.prod.outlook.com>
 <20230830114731.00003590@Huawei.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <20230830114731.00003590@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On 30/08/2023 11:47, Jonathan Cameron wrote:
> On Tue, 29 Aug 2023 17:18:53 +0000
> Amit Singh Tomar <amitsinght@marvell.com> wrote:
>> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com> 
>> James probably also has views on this, but I wouldn't expect userspace to go anywhere near ACPI parsing.

I agree wholeheartedly! Parsing the ACPI tables also wouldn't work: the firmware tables
describe where the MPAM hardware is, but the features that are supported are described by
the hardware, then grouped to find the common features we can make use of.


>> If the description of what MPAM features are supported (before resctrl is running) is necessary, then we
>> should add it to the existing description of the various caches etc.  Maybe somewhere in
>> /sys/bus/node/devices/nodeX/cpuY/cache/indexZ/

>> for the caches
>> and
>> /sys/bus/node/devices/nodeX for the DRAM controllers.

>> [>>] Or may be all the MPAM features list is unified at one place, something like this ?  
>> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot/v6.5-rc1&id=c32874cd1d68241c481a9d0c32c8c65d019c247e
> 
> Fine for debug, not for generic tooling.

Yeah, this is really just for folk reporting bugs to me so we can work out what their
firmware table described, and what the driver found.


Thanks,

James
