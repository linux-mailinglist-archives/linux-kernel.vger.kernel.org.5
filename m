Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016FE77421C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjHHRdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbjHHRdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:33:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5736CF9AD;
        Tue,  8 Aug 2023 09:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691511260; x=1723047260;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6E3zUb6/NEugjKKZc75BbM8cZtlhcP8DTFJjcRbbeRk=;
  b=ZtKc5i6q8nMp+3b70AuRhSTI/NlcCnh0M37DPAV20FWiOIOpTRyGc4V0
   m8zcGNs1WU5HPdrulRtCtRqopoCElnWVWMcCxHYCJ9NizACxsC5M7C9Q0
   SKIiZNHNea54fGOc6GgxSHLujlMMFJwuPxFhOyPzAreE1FGnMJuQhfpHJ
   EPFwWuplHr2HrQm74fz5ocVqioraFSGpxisfcNluFhzR+QpAlL1GkR8nc
   99Iy0dZJhmUEyeTFYc2Au8LqiTe6pC50ZZrp3HOUrkhVgQyL0J24l0syH
   O1xcf8oCpbqlmCWRX3trHuiOS0xpYqxHSZO4sqq73hAUpVBpVxghNDLvE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="370831431"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="370831431"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 07:54:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="821405983"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="821405983"
Received: from mgeppert-mobl1.amr.corp.intel.com (HELO [10.209.105.34]) ([10.209.105.34])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 07:54:30 -0700
Message-ID: <2425e00b-defb-c12b-03e5-c3d23b30be01@linux.intel.com>
Date:   Tue, 8 Aug 2023 07:54:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Dan Williams <dan.j.williams@intel.com>, dhowells@redhat.com
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com>
 <64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch>
 <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
 <64cdb5f25c56_2138e294f1@dwillia2-xfh.jf.intel.com.notmuch>
 <1180481830431165d49c5e64b92b81c396ebc9b1.camel@HansenPartnership.com>
 <64d17f5728fbc_5ea6e2943f@dwillia2-xfh.jf.intel.com.notmuch>
 <c7d6e953a4b36014ea0c7406531b24bb29d6127e.camel@HansenPartnership.com>
Content-Language: en-US
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <c7d6e953a4b36014ea0c7406531b24bb29d6127e.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/23 7:19 AM, James Bottomley wrote:
> On Mon, 2023-08-07 at 16:33 -0700, Dan Williams wrote:
>> James Bottomley wrote:
>>> On Fri, 2023-08-04 at 19:37 -0700, Dan Williams wrote:
>>>> James Bottomley wrote:
>>>> [..]
>>>>>> This report interface on the other hand just needs a single
>>>>>> ABI to retrieve all these vendor formats (until industry
>>>>>> standardization steps in) and it needs to be flexible (within
>>>>>> reason) for all the TSM-specific options to be conveyed. I do
>>>>>> not trust my ioctl ABI minefield avoidance skills to get that
>>>>>> right. Key blob instantiation feels up to the task.
>>>>>
>>>>> To repeat: there's nothing keylike about it.
>>>>
>>>> From that perspective there's nothing keylike about user-keys
>>>> either.
>>>
>>> Whataboutism may be popular in politics at the moment, but it
>>> shouldn't be a justification for API abuse: Just because you might
>>> be able to argue something else is an abuse of an API doesn't give
>>> you the right to abuse it further.
>>
>> That appears to be the disagreement, that the "user" key type is an
>> abuse of the keyctl subsystem. Is that the general consensus that it
>> was added as a mistake that is not be repeated?
> 
> I didn't say anything about your assertion, just that you seemed to be
> trying to argue it.  However, if you look at the properties of keys:
> 
> https://www.kernel.org/doc/html/v5.0/security/keys/core.html
> 
> You'll see that none of them really applies to the case you're trying
> to add.
> 
>> Otherwise there is significant amount of thought that has gone into
>> keyctl including quotas, permissions, and instantiation flows.
>>
>>
>>>> Those are just blobs that userspace gets to define how they are
>>>> used and the keyring is just a transport. I also think that this
>>>> interface *is* key-like in that it is used in the flow of
>>>> requesting other key material. The ability to set policy on who
>>>> can request and instantiate these pre-requisite reports can be
>>>> controlled by request-key policy.
>>>
>>> I thought we agreed back here:
>>>
>>> https://lore.kernel.org/linux-coco/64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch/
>>>
>>> That it ended up as "just a transport interface".  Has something
>>> changed that?
>>
>> This feedback cast doubt on the assumption that attestation reports
>> are infrequently generated:
>>
>> http://lore.kernel.org/r/CAAH4kHbsFbzL=0gn71qq1-1kL398jiS2rd3as1qUFnLTCB5mHQ@mail.gmail.com
> 
> Well, I just read attestation would be called more than once at boot. 
> That doesn't necessarily require a concurrent interface.
> 

Agree. Currently, both sev-guest and tdx-guest (Quote generation part) IOCTL
drivers use a mutex to serialize the cmd requests. By design, TDX GET_QUOTE
hypercall also does not support concurrent requests. Since the attestation
request is expected to be less frequent and not time-critical, I  don't see a
need to support concurrent interfaces.

>> Now, the kernel is within its rights to weigh in on that question
>> with an ABI that is awkward for that use case, or it can decide up
>> front that sysfs is not built for transactions.
> 
> I thought pretty much everyone agreed sysfs isn't really transactional.
> However, if the frequency of use of this is low enough, CC attestation
> doesn't need to be transactional either.  All you need is the ability
> to look at the inputs and outputs and to specify new ones if required.
> Sysfs works for this provided two entities don't want to supply inputs
> at the same time.
> 
>>> [...]
>>>>> Sneaking it in as a one-off is the wrong way to proceed
>>>>> on something like this.
>>>>
>>>> Where is the sneaking in cc'ing all the relevant maintainers of
>>>> the keyring subsystem and their mailing list? Yes, please add
>>>> others to the cc. 
>>>
>>> I was thinking more using the term pubkey in the text about
>>> something that is more like a nonce:
>>>
>>> https://lore.kernel.org/linux-coco/169057265801.180586.10867293237672839356.stgit@dwillia2-xfh.jf.intel.com/
>>>
>>> That looked to me designed to convince the casual observer that
>>> keys were involved.
>>
>> Ok, I see where you were going, at the same time I was trusting
>> keyrings@ community to ask about that detail and was unaware of any
>> advocacy against new key types.
> 
> I'm not advocating against new key types.  I'm saying what you're
> proposing is simply a data transport layer and, as such, has no
> properties that really make it a key type.
> 
>>>> The question for me at this point is whether a new:
>>>>
>>>>         /dev/tsmX
>>>>
>>>> ...ABI is worth inventing, or if a key-type is sufficient. To
>>>> Peter's concern, this key-type imposes no restrictions over what
>>>> sevguest already allows. New options are easy to add to the key
>>>> instantiation interface and I expect different vendors are likely
>>>> to develop workalike functionality to keep option proliferation
>>>> to a minimum. Unlike ioctl() there does not need to be as careful
>>>> planning about the binary format of the input payload for per
>>>> vendor options. Just add more tokens to the instantiation
>>>> command-line.
>>>
>>> I still think this is pretty much an arbitrary transport interface.
>>> The question of how frequently it is used and how transactional it
>>> has to be depend on the use cases (which I think would bear further
>>> examination).  What you mostly want to do is create a transaction
>>> by adding parameters individually, kick it off and then read a set
>>> of results back.  Because the format of the inputs and outputs is
>>> highly specific to the architecture, the kernel shouldn't really be
>>> doing any inspection or modification.  For low volume single
>>> threaded use, this can easily be done by sysfs.  For high volume
>>> multi-threaded use, something like configfs or a generic keyctl
>>> like object transport interface would be more appropriate. 
>>> However, if you think the latter, it should still be proposed as a
>>> new generic kernel to userspace transactional transport mechanism.
>>
>> Perhaps we can get more detail about the proposed high-volume use
>> case: Dionna, Peter?
> 
> Well, that's why I asked for use cases.  I have one which is very low
> volume and single threaded.  I'm not sure what use case you have since
> you never outlined it and I see hints from Red Hat that they worry
> about concurrency.  So it's interface design 101: collect the use cases
> first.
> 
>> I think the minimum bar for ABI success here is that options are not
>> added without touching a common file that everyone can agree what the
>> option is, no more drivers/virt/coco/$vendor ABI isolation. If
>> concepts like VMPL and RTMR are going to have cross-vendor workalike
>> functionality one day then the kernel community picks one name for
>> shared concepts. The other criteria for success is that the frontend
>> needs no change when standardization arrives, assuming all vendors
>> get their optionality into that spec definition.
> 
> I don't think RTMR would ever be cross vendor.  It's sort of a cut down
> TPM with a limited number of PCRs.  Even Intel seems to be admitting
> this when they justified putting a vTPM into TDX at the OC3 Q and A
> session (no tools currently work with RTMRs and the TPM ecosystem is
> fairly solid, so using a vTPM instead of RTMRs gives us an industry
> standard workflow).
> 
> James
> 
> 
>> keyring lessened my workload with how it can accept ascii token
>> options whereas ioctl() needs more upfront thought.
> 
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
