Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B637EA6E9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 00:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjKMXVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 18:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjKMXVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 18:21:44 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7BCD71
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 15:21:39 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso65931961fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 15:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1699917698; x=1700522498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=16UHKTiJBBdygB3NDxQg1vSNAYLocg/Q+/o22+Gc4VM=;
        b=R9KN89sYoE/N+duK+AjQhl/datsRFFG727K85SuRqRCpk5GBNF3O2E93GBmTu2fnJr
         +FK1vMXBhkd15On5TCWykOBIlaTS/bAzi2yLbkSVVOIQFUZUVSTScm2sCw9GELBWc6RG
         z4pxSclCXjU2xCEK0+/AFs+ClfPCRZPUhvThY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699917698; x=1700522498;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=16UHKTiJBBdygB3NDxQg1vSNAYLocg/Q+/o22+Gc4VM=;
        b=vRR7nplE8dC3bN77mM2WmIrjU61nEQLY9IZVUVOs5Oll5mp120M8AjXMxxl03YPwrJ
         H1vJll8utCQJji5aFDqyIjEY2FbnEtxPVofc025tnzwBRSGPI4J+IXBQBI1kX8392p80
         c5bkacB+pDJ3W02Ah7cXVkU2R6EgRJsOIyZrZ+0kDeogjuK2398BvII88bqWa9AKpxjh
         dp3UZZMhXX3eBWuaRK0790R63bIj8k0aqzBGrjemCMHFHRRyH0ZmgpZz0ZOm1I+SEHwQ
         05nxDasSHqcU2Jhb7qN2PP1+LEAM32EDWYgEjtkzxS/NMiBOPc5iHGuMaB9ixf5MHXn6
         wozg==
X-Gm-Message-State: AOJu0YzuzZzQx4IfWpZdreHueqZd98OD7E2rAG2Md9gia9x9iF2WgW13
        Y+YnOCF0pSqP//SEZ7DYfe2TUw==
X-Google-Smtp-Source: AGHT+IEFbywTuiCM3Qsf46VdvQGP+jWzn8QiLDib6v40aY/R+2Y0qrS+3M5SUqyMVbx0tvNqsu2OdA==
X-Received: by 2002:a2e:3602:0:b0:2c5:623:aa01 with SMTP id d2-20020a2e3602000000b002c50623aa01mr436845lja.49.1699917697666;
        Mon, 13 Nov 2023 15:21:37 -0800 (PST)
Received: from [172.25.82.51] ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id v4-20020ac87284000000b0041eef6cacf4sm2262161qto.81.2023.11.13.15.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 15:21:37 -0800 (PST)
Message-ID: <8703f1a9-5d4d-4c5a-b9aa-3b31ad2dcd41@citrix.com>
Date:   Mon, 13 Nov 2023 23:21:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/13] x86: Add early SHA support for Secure Launch
 early measurements
Content-Language: en-GB
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        luto@amacapital.net, nivedita@alum.mit.edu,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
References: <20231110222751.219836-1-ross.philipson@oracle.com>
 <20231110222751.219836-7-ross.philipson@oracle.com>
 <20231111174435.GA998@sol.localdomain>
 <a16d44c5-2e1a-4e9a-8ca1-c7ca564f61cd@citrix.com>
 <87f56530b85ea894036a74be1824d6f2716f70de.camel@HansenPartnership.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 xsFNBFLhNn8BEADVhE+Hb8i0GV6mihnnr/uiQQdPF8kUoFzCOPXkf7jQ5sLYeJa0cQi6Penp
 VtiFYznTairnVsN5J+ujSTIb+OlMSJUWV4opS7WVNnxHbFTPYZVQ3erv7NKc2iVizCRZ2Kxn
 srM1oPXWRic8BIAdYOKOloF2300SL/bIpeD+x7h3w9B/qez7nOin5NzkxgFoaUeIal12pXSR
 Q354FKFoy6Vh96gc4VRqte3jw8mPuJQpfws+Pb+swvSf/i1q1+1I4jsRQQh2m6OTADHIqg2E
 ofTYAEh7R5HfPx0EXoEDMdRjOeKn8+vvkAwhviWXTHlG3R1QkbE5M/oywnZ83udJmi+lxjJ5
 YhQ5IzomvJ16H0Bq+TLyVLO/VRksp1VR9HxCzItLNCS8PdpYYz5TC204ViycobYU65WMpzWe
 LFAGn8jSS25XIpqv0Y9k87dLbctKKA14Ifw2kq5OIVu2FuX+3i446JOa2vpCI9GcjCzi3oHV
 e00bzYiHMIl0FICrNJU0Kjho8pdo0m2uxkn6SYEpogAy9pnatUlO+erL4LqFUO7GXSdBRbw5
 gNt25XTLdSFuZtMxkY3tq8MFss5QnjhehCVPEpE6y9ZjI4XB8ad1G4oBHVGK5LMsvg22PfMJ
 ISWFSHoF/B5+lHkCKWkFxZ0gZn33ju5n6/FOdEx4B8cMJt+cWwARAQABzSlBbmRyZXcgQ29v
 cGVyIDxhbmRyZXcuY29vcGVyM0BjaXRyaXguY29tPsLBegQTAQgAJAIbAwULCQgHAwUVCgkI
 CwUWAgMBAAIeAQIXgAUCWKD95wIZAQAKCRBlw/kGpdefoHbdD/9AIoR3k6fKl+RFiFpyAhvO
 59ttDFI7nIAnlYngev2XUR3acFElJATHSDO0ju+hqWqAb8kVijXLops0gOfqt3VPZq9cuHlh
 IMDquatGLzAadfFx2eQYIYT+FYuMoPZy/aTUazmJIDVxP7L383grjIkn+7tAv+qeDfE+txL4
 SAm1UHNvmdfgL2/lcmL3xRh7sub3nJilM93RWX1Pe5LBSDXO45uzCGEdst6uSlzYR/MEr+5Z
 JQQ32JV64zwvf/aKaagSQSQMYNX9JFgfZ3TKWC1KJQbX5ssoX/5hNLqxMcZV3TN7kU8I3kjK
 mPec9+1nECOjjJSO/h4P0sBZyIUGfguwzhEeGf4sMCuSEM4xjCnwiBwftR17sr0spYcOpqET
 ZGcAmyYcNjy6CYadNCnfR40vhhWuCfNCBzWnUW0lFoo12wb0YnzoOLjvfD6OL3JjIUJNOmJy
 RCsJ5IA/Iz33RhSVRmROu+TztwuThClw63g7+hoyewv7BemKyuU6FTVhjjW+XUWmS/FzknSi
 dAG+insr0746cTPpSkGl3KAXeWDGJzve7/SBBfyznWCMGaf8E2P1oOdIZRxHgWj0zNr1+ooF
 /PzgLPiCI4OMUttTlEKChgbUTQ+5o0P080JojqfXwbPAyumbaYcQNiH1/xYbJdOFSiBv9rpt
 TQTBLzDKXok86M7BTQRS4TZ/ARAAkgqudHsp+hd82UVkvgnlqZjzz2vyrYfz7bkPtXaGb9H4
 Rfo7mQsEQavEBdWWjbga6eMnDqtu+FC+qeTGYebToxEyp2lKDSoAsvt8w82tIlP/EbmRbDVn
 7bhjBlfRcFjVYw8uVDPptT0TV47vpoCVkTwcyb6OltJrvg/QzV9f07DJswuda1JH3/qvYu0p
 vjPnYvCq4NsqY2XSdAJ02HrdYPFtNyPEntu1n1KK+gJrstjtw7KsZ4ygXYrsm/oCBiVW/OgU
 g/XIlGErkrxe4vQvJyVwg6YH653YTX5hLLUEL1NS4TCo47RP+wi6y+TnuAL36UtK/uFyEuPy
 wwrDVcC4cIFhYSfsO0BumEI65yu7a8aHbGfq2lW251UcoU48Z27ZUUZd2Dr6O/n8poQHbaTd
 6bJJSjzGGHZVbRP9UQ3lkmkmc0+XCHmj5WhwNNYjgbbmML7y0fsJT5RgvefAIFfHBg7fTY/i
 kBEimoUsTEQz+N4hbKwo1hULfVxDJStE4sbPhjbsPCrlXf6W9CxSyQ0qmZ2bXsLQYRj2xqd1
 bpA+1o1j2N4/au1R/uSiUFjewJdT/LX1EklKDcQwpk06Af/N7VZtSfEJeRV04unbsKVXWZAk
 uAJyDDKN99ziC0Wz5kcPyVD1HNf8bgaqGDzrv3TfYjwqayRFcMf7xJaL9xXedMcAEQEAAcLB
 XwQYAQgACQUCUuE2fwIbDAAKCRBlw/kGpdefoG4XEACD1Qf/er8EA7g23HMxYWd3FXHThrVQ
 HgiGdk5Yh632vjOm9L4sd/GCEACVQKjsu98e8o3ysitFlznEns5EAAXEbITrgKWXDDUWGYxd
 pnjj2u+GkVdsOAGk0kxczX6s+VRBhpbBI2PWnOsRJgU2n10PZ3mZD4Xu9kU2IXYmuW+e5KCA
 vTArRUdCrAtIa1k01sPipPPw6dfxx2e5asy21YOytzxuWFfJTGnVxZZSCyLUO83sh6OZhJkk
 b9rxL9wPmpN/t2IPaEKoAc0FTQZS36wAMOXkBh24PQ9gaLJvfPKpNzGD8XWR5HHF0NLIJhgg
 4ZlEXQ2fVp3XrtocHqhu4UZR4koCijgB8sB7Tb0GCpwK+C4UePdFLfhKyRdSXuvY3AHJd4CP
 4JzW0Bzq/WXY3XMOzUTYApGQpnUpdOmuQSfpV9MQO+/jo7r6yPbxT7CwRS5dcQPzUiuHLK9i
 nvjREdh84qycnx0/6dDroYhp0DFv4udxuAvt1h4wGwTPRQZerSm4xaYegEFusyhbZrI0U9tJ
 B8WrhBLXDiYlyJT6zOV2yZFuW47VrLsjYnHwn27hmxTC/7tvG3euCklmkn9Sl9IAKFu29RSo
 d5bD8kMSCYsTqtTfT6W4A3qHGvIDta3ptLYpIAOD2sY3GYq2nf3Bbzx81wZK14JdDDHUX2Rs
 6+ahAA==
In-Reply-To: <87f56530b85ea894036a74be1824d6f2716f70de.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2023 8:36 pm, James Bottomley wrote:
> On Sat, 2023-11-11 at 18:19 +0000, Andrew Cooper wrote:
>> On 11/11/2023 5:44 pm, Eric Biggers wrote:
>>> On Fri, Nov 10, 2023 at 05:27:44PM -0500, Ross Philipson wrote:
>>>>  arch/x86/boot/compressed/early_sha1.c   | 12 ++++
>>>>  lib/crypto/sha1.c                       | 81
>>>> +++++++++++++++++++++++++
>>> It's surprising to still see this new use of SHA-1 after so many
>>> people objected to it in the v6 patchset.  It's also frustrating
>>> that the SHA-1 support is still being obfuscated by being combined
>>> in one patch with SHA-2 support, perhaps in an attempt to conflate
>>> the two algorithms and avoid having to give a rationale for the
>>> inclusion of SHA-1.  Finally, new functions should not be added to
>>> lib/crypto/sha1.c unless those functions have multiple users.
>> The rational was given.  Let me reiterate it.
>>
>> There are real TPMs in the world that can't use SHA-2.  The use of
>> SHA-1 is necessary to support DRTM on such systems, and there are
>> real users of such configurations.
> Given that TPM 2.0 has been shipping in bulk since Windows 10 (2015)
> and is required for Windows 11 (2021), are there really such huge
> numbers of TPM 1.2 systems involved in security functions?

Yes.

As ever, it's not as simple as a straight TPM version issue.

AMD's firmware-TPM2 isn't compatible with their DRTM implementation. 
Users are limited to whatever headers are available on the motherboard.

Furthermore, even with a TPM2, it is the firmware (Intel TXT ACM) or
hardware (AMD SKINIT) which chooses the hash algorithms to use, and in a
lot of cases the end user doesn't get a choice.

So yes - there really are modern systems which you can't use SHA-2-only
with.

>> DRTM with SHA-1-only is a damnsight better than no DTRM, even if SHA-
>> 1 is getting a little long in the tooth.
> That's not the problem.  The problem is that sha1 is seen as a
> compromised algorithm by NIST which began deprecating it in 2011 and is
> now requiring it to be removed from all systems supplied to the US
> government by 2030

This is a non-issue.

People who care about having no SHA-1 can not compile in DRTM support.

But there are people who will tolerate SHA-1 code to get DTRM support.

~Andrew
