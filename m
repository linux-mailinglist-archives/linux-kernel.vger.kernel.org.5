Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8447D826B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344889AbjJZMSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjJZMSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:18:40 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A53116
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:18:37 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cc13149621so796655ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698322717; x=1698927517; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nn8IJ+A31H/W9cHH67lHCBS/HFYbioViyKmugnuvJtM=;
        b=Ok9qX8u6VoHNDo0aVTp+26E6E+9AeU5cTcAC6p7dXDJsDlrf5fM61iJXnX6lnhBdeT
         VsWNSRAJCEokwF3eiXUWtBe1vMV3kqyyj2KOBA1aMnpeazsWps9CpA64IgoRRSYG38Ap
         0HncYvkIlduMvrfn2DREUgaIxjxBQ8IpDLLoKRrQ3qGsWoQSsLbKN8LD/edFIDLdhiSU
         s4lcvvq2i+KrhC9lA5SW9sYmREkCO+3BN6+yYf/Kje7LwrlD0D7fj43iPT2HVS+9rYoL
         791c+a5gvWXwmXQKQz1VjzplvrxrxaSH5Tvct6TELpWACmDwbTHkxoST54tZDx0B9oaw
         zCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698322717; x=1698927517;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nn8IJ+A31H/W9cHH67lHCBS/HFYbioViyKmugnuvJtM=;
        b=ZOrX1IyiBg+T77xBv2rNq5XMtWzuwFzL2GMf3Q7OPHv2LEhzeW2sW0PRZp1W6ia7Pw
         26tdHGVMvv3Ruos8woW+bAN2p/rE1qfsU+YzFEKW2pUvrQMXA0PFXCTuEXZgvjkCNILD
         uIwB4iTJtm3kIRLF9ltHIA8at5FH49rTD9PpidjP7AAFknXVOj/IiviYmvshxCjbup6i
         w+XZrh6hsjoOqSCr5j6qoIUdPV0mFJiSQteeWjh8Q7SbBUyUJvwHjkBgowa0Qd/cBciA
         Znp8+9sW+he5dpMe8PBLCV3rQGsgk0o04CoBdF4M4aCzQjD8EQBpyJ9PWJBvj6ZE6fAs
         UEdw==
X-Gm-Message-State: AOJu0YwdbIDjiwUmRkaVVWND1CczSkEi/8a3tODWYplnC4K+N+vuU2gs
        gvi5ksBQkNDp5PLQKW5bcg8=
X-Google-Smtp-Source: AGHT+IGBR3Mbqrv8AlAiltkY3TRkGtkq1GgXPzRgWmBDqhMS9bSaQCMGDwS46PCMtX6VRZMgGYLlGQ==
X-Received: by 2002:a17:902:e291:b0:1ca:273d:232 with SMTP id o17-20020a170902e29100b001ca273d0232mr17069881plc.0.1698322717362;
        Thu, 26 Oct 2023 05:18:37 -0700 (PDT)
Received: from [192.168.0.152] ([103.75.161.208])
        by smtp.gmail.com with ESMTPSA id z16-20020a170903019000b001c60635c13esm10791976plg.115.2023.10.26.05.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 05:18:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------teGJ8Wzf9yOlAohCF2VAu6sM"
Message-ID: <4c171399-87ac-4273-8b73-5d9b440656d2@gmail.com>
Date:   Thu, 26 Oct 2023 17:48:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fixing warning of directly dereferencing __rcu tagged
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     brauner@kernel.org, surenb@google.com, mst@redhat.com,
        michael.christie@oracle.com, mathieu.desnoyers@efficios.com,
        mjguzik@gmail.com, npiggin@gmail.com, shakeelb@google.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20231025222811.855336-1-singhabhinav9051571833@gmail.com>
 <20231025153807.8db950f1db82b2c9ecd03758@linux-foundation.org>
 <c4688c53-4206-4d54-aed9-f877697e8073@gmail.com>
 <20231025165002.64ab92e6d55d204b66e055f4@linux-foundation.org>
Content-Language: en-US
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <20231025165002.64ab92e6d55d204b66e055f4@linux-foundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------teGJ8Wzf9yOlAohCF2VAu6sM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/26/23 05:20, Andrew Morton wrote:
> On Thu, 26 Oct 2023 04:57:42 +0530 Abhinav Singh <singhabhinav9051571833@gmail.com> wrote:
> 
>> On 10/26/23 04:08, Andrew Morton wrote:
>>>> +++ b/kernel/fork.c
>>>> @@ -2369,7 +2369,9 @@ __latent_entropy struct task_struct *copy_process(
>>>>    
>>>>    	retval = -EAGAIN;
>>>>    	if (is_rlimit_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
>>>> -		if (p->real_cred->user != INIT_USER &&
>>>> +		const struct cred *real_cred = rcu_dereference(p->real_cred);
>>>> +
>>>> +		if (real_cred && real_cred->user != INIT_USER &&
>>>>    		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
>>>>    			goto bad_fork_cleanup_count;
>>>
>>> The old code assumes that p->read_cred cannot be NULL and the new code
>>> does nothing to make it possible that `real_cred' can be NULL?
>>>
>>> In other words, I see no reason to add this new check for NULL?
>>
>> Thank you for the response!
>>
>> I thought it will be better to have check before accessing it, just so
>> we dont have any segmentation fault in future.
> 
> That would be adding code which has no effect?
> 
>> Also I just noticed there are two more places where direct dereferencing
>> of __rcu pointer is done in this same file. Should I do those changes in
>> this patch ?
> 
> I don't see why.  rcu_dereference(p) cannot return NULL if `p' is non-NULL?


--------------teGJ8Wzf9yOlAohCF2VAu6sM
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Fixing-sparse-warning-cast-removes-address-space-__i.patch"
Content-Disposition: attachment;
 filename*0="0001-Fixing-sparse-warning-cast-removes-address-space-__i.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA1OThiZjgyYjYxMWE5YWY5NmM1ZDQxMjg1NTk1N2UzNzg1MjNmNTI5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBYmhpbmF2IFNpbmdoIDxzaW5naGFiaGluYXY5MDUx
NTcxODMzQGdtYWlsLmNvbT4KRGF0ZTogVHVlLCAyNCBPY3QgMjAyMyAxNToyNDo1MiArMDUz
MApTdWJqZWN0OiBbUEFUQ0hdIEZpeGluZyB3YXJuaW5nIGNhc3QgcmVtb3ZlcyBhZGRyZXNz
IHNwYWNlICdfX2lvbWVtJyBvZgogZXhwcmVzc2lvbgoKVGhpcyBwYXRjaCBmaXhlcyBzcGFy
c2UgY29tcGxhaW5pbmcgYWJvdXQgdGhlIHJlbW92YWwgb2YgX19pb21lbSBhZGRyZXNzCnNw
YWNlIHdoZW4gY2FzdGluZyB0aGUgcmV0dXJuIHZhbHVlIG9mIHRoaXMgZnVuY3Rpb24gaW9y
ZW1hcF9jYWNoZSguLi4pCmZyb20gYHZvaWQgX19pb3JlbWFwKmAgdG8gYHZvaWQqYC4KCkkg
dGhpbmsgdGhlcmUgYXJlIHR3byB3YXkgb2YgZml4aW5nIGl0LCBmaXJzdCBvbmUgaXMgY2hh
bmdpbmcgdGhlCmRhdGF0eXBlIG9mIHZhcmlhYmxlIGBnaGNiX3ZhYCBmcm9tIGB2b2lkKmAg
dG8gYHZvaWQgX19pb21lbSpgIC4gClNlY29uZCB3YXkgb2YgZml4aW5nIGl0IGlzIHVzaW5n
IHRoZSBtZW1yZW1hcCguLi4pIHdoaWNoIGlzIApkb25lIGluIHRoaXMgcGF0Y2guCgpTaWdu
ZWQtb2ZmLWJ5OiBBYmhpbmF2IFNpbmdoIDxzaW5naGFiaGluYXY5MDUxNTcxODMzQGdtYWls
LmNvbT4KLS0tCiBhcmNoL3g4Ni9oeXBlcnYvaHZfaW5pdC5jIHwgMiArLQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvYXJj
aC94ODYvaHlwZXJ2L2h2X2luaXQuYyBiL2FyY2gveDg2L2h5cGVydi9odl9pbml0LmMKaW5k
ZXggMjE1NTZhZDg3ZjRiLi5jMTQxNjFhZGQyNzQgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2h5
cGVydi9odl9pbml0LmMKKysrIGIvYXJjaC94ODYvaHlwZXJ2L2h2X2luaXQuYwpAQCAtNzAs
NyArNzAsNyBAQCBzdGF0aWMgaW50IGh5cGVydl9pbml0X2doY2Iodm9pZCkKIAogCS8qIE1h
c2sgb3V0IHZUT00gYml0LiBpb3JlbWFwX2NhY2hlKCkgbWFwcyBkZWNyeXB0ZWQgKi8KIAln
aGNiX2dwYSAmPSB+bXNfaHlwZXJ2LnNoYXJlZF9ncGFfYm91bmRhcnk7Ci0JZ2hjYl92YSA9
ICh2b2lkICopaW9yZW1hcF9jYWNoZShnaGNiX2dwYSwgSFZfSFlQX1BBR0VfU0laRSk7CisJ
Z2hjYl92YSA9IG1lbXJlbWFwKGdoY2JfZ3BhLCBIVl9IWVBfUEFHRV9TSVpFLCBNRU1SRU1B
UF9XQik7CiAJaWYgKCFnaGNiX3ZhKQogCQlyZXR1cm4gLUVOT01FTTsKIAotLSAKMi4zOS4y
Cgo=

--------------teGJ8Wzf9yOlAohCF2VAu6sM--
