Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225C4779D19
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 06:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjHLEHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 00:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHLEHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 00:07:05 -0400
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8131FD9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 21:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1691813216;
        bh=UWT4oWMKiN5RSdzaXy1VtdFP1tYUeYZEX+Ed2x0DAig=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To;
        b=BncnPkRccSw3I1Ajyup/QXwTcAEF3IAN7NCjUbGFdDAljHtmUhB9y5ayz+obajwo5
         /pOxw7/zJAXbJpV+VJmWs3B6Vh6WjE0/wWXFcUzBfoeadawZvYVOwV0XfZ6rYP9qX+
         sA2+C4rYvH53Im7MHGIORVYx0LMgTT7cBhhQlj4M=
Received: from [172.25.21.182] ([175.152.51.41])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id EBB99416; Sat, 12 Aug 2023 11:58:59 +0800
X-QQ-mid: xmsmtpt1691812739t6plfk5rm
Message-ID: <tencent_594804A808BD93A4EBF50A994F228E3A7F07@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUAnTYdKp/uelekxuNpmEagXKaHW/lMzRw2s9WndM53XjWmkoeTmw
         d/oBBpQuu1c7a5+Pq9HJ+XbbtWfi0sBP27N61xPf0ULKHwUsNZI0F+olRFNzYB3PpHmpPtMAkBFI
         ALkVdiozL+LbsZmHBAYU8ctQSZQClIPIWRY5qMa5bNpJuISj9UzLs7aBEEr+02OiKV/NFXnmQdxv
         gFhBrA3uOCjJQgoxLH9AyIw/P4qrgdQRqgBBHglyZFluASf6/+6HnGQQEcq3LGzPQbfo9561hJ0C
         +w0c6GI9Zefhq5tCYf1zNNDAyCPHRYv87HzHdlEdDRt4lyj9HarWnMUnpu5+kBX6CWaDHx/kGVV2
         l41Ke3FO3TsX/dJAcyKXONwsmnbJiK393F7152kkR+tt8bz6gbS+9CCHYiH9gSSUpU6Z/Vjaoasq
         UedsCagKbADjW4qY2qQtUPE6glOg8qQWyh+idNBfbSpOdsM1reopgIKsoSHT5qIItvc/jcZgcdiQ
         Na6I7JbbCmYzxuyCqi3lp+dnC/xl32R/Z9GXrr+djqvCySEe9VtVtP23P7S5x3B/TVt3TCTIx1bw
         E7tx2hQBN4WEFP5+PNffRsremK0lybVFnKB6+hiOWKZBjexkuVMfs8Cb790GQRYhndlTHvmfPp93
         lZf5d6Wr7BfEEnqQjtmvtqqcSsqjWDyg6jLmpyCe1C0Pbb7Av+Mp+o9erULQgWGlAkEo2ndGTSLm
         xNNx48HgI2YQTluDhJLkkmwdhFxIy3Sg8Su9xqXmfpckR/dw+FipJ8kw0/K7NB6G0DJub8khsaCa
         IVEUaDr1s3BlcvQt4aeBN8/AjUTTOSWvOiMww4yzowlRSQ/QmG1eeT6zUSjSjPW7BjIkqxc/l4Vw
         OZDhGJnyVNnBENi7/aV8YxiYTeg5B5wN6RbfegWMXnmnvnJ93NJEp8JXr8XK+6lVoIo6+sDdLrTl
         sM1pFO/0P5RTF5kq9+n9kebYi+WSZkXfklRwtScOSWH9q+sDwaEKKUg+pGdxF5
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From:   Pu Wen <pu_wen@foxmail.com>
Subject: Re: [patch V3a 30/40] x86/cpu: Provide an AMD/HYGON specific topology
 parser
To:     Thomas Gleixner <tglx@linutronix.de>, Pu Wen <puwen@hygon.cn>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
References: <20230802101635.459108805@linutronix.de>
 <20230802101934.418143974@linutronix.de> <87il9xjk95.ffs@tglx>
 <tencent_3C08D6938E6BD58AACCF018E0A7F3B848807@qq.com> <87jzu1h5cm.ffs@tglx>
X-OQ-MSGID: <de005a57-c359-ca06-68ae-e35b4daa0d42@foxmail.com>
Date:   Sat, 12 Aug 2023 11:58:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <87jzu1h5cm.ffs@tglx>
Content-Type: multipart/mixed;
 boundary="------------F74B0721D17C2FBD71D000F9"
Content-Language: en-US
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F74B0721D17C2FBD71D000F9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/12 1:11, Thomas Gleixner wrote:
> On Fri, Aug 11 2023 at 20:58, Pu Wen wrote:
>> On 2023/8/3 3:51, Thomas Gleixner wrote:
>>> +	if (tscan->c->x86_vendor == X86_VENDOR_AMD) {
>>> +		if (tscan->c->x86 == 0x15)
>>> +			tscan->c->topo.cu_id = leaf.cuid;
>>> +
>>> +		cacheinfo_amd_init_llc_id(tscan->c, leaf.nodeid);
>>> +	} else {
>>> +		/*
>>> +		 * Package ID is ApicId[6..] on Hygon CPUs. See commit
>>> +		 * e0ceeae708ce for explanation. The topology info is
>>> +		 * screwed up: The package shift is always 6 and the node
>>> +		 * ID is bit [4:5]. Don't touch the latter without
>>> +		 * confirmation from the Hygon developers.
>>> +		 */
>>> +		topology_set_dom(tscan, TOPO_CORE_DOMAIN, 6, tscan->dom_ncpus[TOPO_CORE_DOMAIN]);
>>
>> Hygon updated CPUs will not always shift 6, and shift 6 is not good for
>> running guests.
>> So suggest to modify like this:
>>       if (!boot_cpu_has(X86_FEATURE_HYPERVISOR) && tscan->c->x86_model <=
>> 0x3)
>>           topology_set_dom(tscan, TOPO_CORE_DOMAIN, 6,
>> tscan->dom_ncpus[TOPO_CORE_DOMAIN]);
> 
> This is exactly what the existing code does today. Can you please send a
> delta patch on top of this with a proper explanation?

Will.

And I think it's better to send a prerequisite patch(is attached) after
patch 02 of this series. Since it can be individually back-ported to the
stable releases.

-- 
Regards,
Pu Wen



--------------F74B0721D17C2FBD71D000F9
Content-Type: text/plain; charset=UTF-8;
 name="x86-cpu-Refine-the-CPU-topology-deriving-method-for-Hygon.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="x86-cpu-Refine-the-CPU-topology-deriving-method-for-Hygon.pa";
 filename*1="tch"

RnJvbSA3NjhhZjcwMDlmNmZhOWY5YzQwMjUxYzU5NzlmNjExNDc5MTY1ZGM0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQdSBXZW4gPHB1d2VuQGh5Z29uLmNuPgpEYXRlOiBT
YXQsIDEyIEF1ZyAyMDIzIDExOjQxOjA2ICswODAwClN1YmplY3Q6IFtQQVRDSF0geDg2L2Nw
dTogUmVmaW5lIHRoZSBDUFUgdG9wb2xvZ3kgZGVyaXZpbmcgbWV0aG9kIGZvciBIeWdvbgoK
SHlnb24gdXBkYXRlZCBwcm9jZXNzb3JzIHdpbGwgbm90IGFsd2F5cyBzaGlmdCA2IGFuZCB1
c2UgdGhlIHJlc3VsdApvZiBDUFVJRCBsZWFmIDB4QiB0byBkZXJpdmUgdGhlIHNvY2tldCBJ
RC4KCklmIHJ1bm5pbmcgb24gZ3Vlc3QsIHRoZSBBcGljSUQgaXMgbm90IHRoZSBzYW1lIGFz
IGhvc3Qncywgc28ganVzdAp1c2UgdGhlIGh5cGVydmlzb3IncyBkZWZhdWx0LgoKQ2M6IDxz
dGFibGVAdmdlci5rZXJuZWwub3JnPiAjIHY1LjIrCkZpeGVzOiBlMGNlZWFlNzA4Y2UgKCJ4
ODYvQ1BVL2h5Z29uOiBGaXggcGh5c19wcm9jX2lkIGNhbGN1bGF0aW9uIGxvZ2ljIGZvciBt
dWx0aS1kaWUgcHJvY2Vzc29ycyIpClNpZ25lZC1vZmYtYnk6IFB1IFdlbiA8cHV3ZW5AaHln
b24uY24+Ci0tLQogYXJjaC94ODYva2VybmVsL2NwdS9oeWdvbi5jIHwgOCArKysrKystLQog
MSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2h5Z29uLmMgYi9hcmNoL3g4Ni9rZXJuZWwv
Y3B1L2h5Z29uLmMKaW5kZXggZGVmZGM1OTRiZTE0Li5hN2IzZWY0YzRkZTkgMTAwNjQ0Ci0t
LSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvaHlnb24uYworKysgYi9hcmNoL3g4Ni9rZXJuZWwv
Y3B1L2h5Z29uLmMKQEAgLTg3LDggKzg3LDEyIEBAIHN0YXRpYyB2b2lkIGh5Z29uX2dldF90
b3BvbG9neShzdHJ1Y3QgY3B1aW5mb194ODYgKmMpCiAJCWlmICghZXJyKQogCQkJYy0+eDg2
X2NvcmVpZF9iaXRzID0gZ2V0X2NvdW50X29yZGVyKGMtPng4Nl9tYXhfY29yZXMpOwogCi0J
CS8qIFNvY2tldCBJRCBpcyBBcGljSWRbNl0gZm9yIHRoZXNlIHByb2Nlc3NvcnMuICovCi0J
CWMtPnBoeXNfcHJvY19pZCA9IGMtPmFwaWNpZCA+PiBBUElDSURfU09DS0VUX0lEX0JJVDsK
KwkJLyoKKwkJICogU29ja2V0IElEIGlzIEFwaWNJZFs2XSBmb3IgdGhlIHByb2Nlc3NvcnMg
d2l0aCBtb2RlbCA8PSAweDMKKwkJICogd2hlbiBydW5uaW5nIG9uIGhvc3QuCisJCSAqLwor
CQlpZiAoIWJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9IWVBFUlZJU09SKSAmJiBjLT54ODZf
bW9kZWwgPD0gMHgzKQorCQkJYy0+cGh5c19wcm9jX2lkID0gYy0+YXBpY2lkID4+IEFQSUNJ
RF9TT0NLRVRfSURfQklUOwogCiAJCWNhY2hlaW5mb19oeWdvbl9pbml0X2xsY19pZChjLCBj
cHUpOwogCX0gZWxzZSBpZiAoY3B1X2hhcyhjLCBYODZfRkVBVFVSRV9OT0RFSURfTVNSKSkg
ewotLSAKMi4yMy4wCgo=
--------------F74B0721D17C2FBD71D000F9--

