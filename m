Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A35F7849EC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjHVTHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjHVTHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:07:13 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F27C4E56;
        Tue, 22 Aug 2023 12:07:04 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1152)
        id 7C04A2126CD2; Tue, 22 Aug 2023 12:07:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7C04A2126CD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692731224;
        bh=whYffB2KfagGrQHJGCkbdR1Z999poStA2tZvLaZ3rXY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Q8Ju5xkD2umspXxrx50ajhElN8beTyaEtOlHmbsFeyq5OwhCHYFPrnDXTbGa8Tcqv
         g60b+aosmK2PXEW3udE3rH0X8jPv/CjbARwGYm1gP1YFhykMFKjNFWakyNNBeoPdns
         vY13LzzJbcsBSTX82ty7AF3/MYLzd9tJN0QsXcd4=
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id 77D5330705C5;
        Tue, 22 Aug 2023 12:07:04 -0700 (PDT)
Date:   Tue, 22 Aug 2023 12:07:04 -0700 (PDT)
From:   Shyam Saini <shyamsaini@linux.microsoft.com>
To:     Sumit Garg <sumit.garg@linaro.org>
cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-scsi@vger.kernel.org,
        =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        Tyler Hicks <code@tyhicks.com>,
        "Srivatsa S . Bhat" <srivatsa@csail.mit.edu>,
        Paul Moore <paul@paul-moore.com>,
        Allen Pais <apais@linux.microsoft.com>
Subject: Re: [RFC, PATCH 1/1] rpmb: add Replay Protected Memory Block (RPMB)
 driver
In-Reply-To: <CAFA6WYMPsBUutjKrm+6qTNHpVr80K2GcSLoYa+MFE3CfLSo8ew@mail.gmail.com>
Message-ID: <226aa02d-1247-a42c-123d-1c86b6b43d9f@linux.microsoft.com>
References: <20230722014037.42647-1-shyamsaini@linux.microsoft.com> <20230722014037.42647-2-shyamsaini@linux.microsoft.com> <CAPDyKFoBC+GaGerGDEAjg9q4ayV9mMBKkfFk3nO-zcQzOZ_H6Q@mail.gmail.com> <b875892c-1777-d84a-987e-1b0d5ac29df@linux.microsoft.com>
 <94728786-b41b-1467-63c1-8e2d5acfa5e4@linaro.org> <CAFA6WYNPViMs=3cbNsEdhqnjNOUCsHE_8uqiDTzwCKDNNiDkCw@mail.gmail.com> <CAHUa44Ek0k2b-igA6Gd1ZXVzibTh2sNDMnE-weQwFFKEZ_1jOA@mail.gmail.com> <CAC_iWjKKap47PhiCi=BfPZC_wJhVDB10WSf9oWMgdwSgWCfO_A@mail.gmail.com>
 <CAFA6WYMPsBUutjKrm+6qTNHpVr80K2GcSLoYa+MFE3CfLSo8ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="656392-1544379424-1692731224=:12353"
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--656392-1544379424-1692731224=:12353
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT


> On Mon, 21 Aug 2023 at 17:26, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> On Mon, 21 Aug 2023 at 14:19, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>>>
>>> On Mon, Aug 21, 2023 at 12:03 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>>>>
>>>> On Mon, 21 Aug 2023 at 15:19, Jerome Forissier
>>>> <jerome.forissier@linaro.org> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 8/17/23 01:31, Shyam Saini wrote:
>>>>>>
>>>>>> Hi Ulf,
>>>>>>
>>>>>>> On Sat, 22 Jul 2023 at 03:41, Shyam Saini
>>>>>>> <shyamsaini@linux.microsoft.com> wrote:
>>>>>>>>
>>>>>>>> From: Alex Bennée <alex.bennee@linaro.org>
>>>>>>>>
>>>>>>>> [This is patch 1 from [1] Alex's submission and this RPMB layer was
>>>>>>>> originally proposed by [2]Thomas Winkler ]
>>>>>>>>
>>>>>>>> A number of storage technologies support a specialised hardware
>>>>>>>> partition designed to be resistant to replay attacks. The underlying
>>>>>>>> HW protocols differ but the operations are common. The RPMB partition
>>>>>>>> cannot be accessed via standard block layer, but by a set of specific
>>>>>>>> commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
>>>>>>>> partition provides authenticated and replay protected access, hence
>>>>>>>> suitable as a secure storage.
>>>>>>>>
>>>>>>>> The initial aim of this patch is to provide a simple RPMB Driver which
>>>>>>>> can be accessed by Linux's optee driver to facilitate fast-path for
>>>>>>>> RPMB access to optee OS(secure OS) during the boot time. [1] Currently,
>>>>>>>> Optee OS relies on user-tee supplicant to access eMMC RPMB partition.
>>>>>>>>
>>>>>>>> A TEE device driver can claim the RPMB interface, for example, via
>>>>>>>> class_interface_register(). The RPMB driver provides a series of
>>>>>>>> operations for interacting with the device.
>>>>>>>
>>>>>>> I don't quite follow this. More exactly, how will the TEE driver know
>>>>>>> what RPMB device it should use?
>>>>>>
>>>>>> I don't have complete code to for this yet, but i think OP-TEE driver
>>>>>> should register with RPMB subsystem and then we can have eMMC/UFS/NVMe
>>>>>> specific implementation for RPMB operations.
>>>>>>
>>>>>> Linux optee driver can handle RPMB frames and pass it to RPMB subsystem
>>>>>>
>>>>
>>>> It would be better to have this OP-TEE use case fully implemented. So
>>>> that we can justify it as a valid user for this proposed RPMB
>>>> subsystem. If you are looking for any further suggestions then please
>>>> let us know.
>>>
>>> +1
>>>
>>>>
>>>>>> [1] U-Boot has mmc specific implementation
>>>>>>
>>>>>> I think OPTEE-OS has CFG_RPMB_FS_DEV_ID option
>>>>>> CFG_RPMB_FS_DEV_ID=1 for /dev/mmcblk1rpmb,
>>>>>
>>>>> Correct. Note that tee-supplicant will ignore this device ID if --rmb-cid
>>>>> is given and use the specified RPMB instead (the CID is a non-ambiguous way
>>>>> to identify a RPMB device).
>>>>>
>>>>>> but in case if a
>>>>>> system has multiple RPMB devices such as UFS/eMMC/NVMe, one them
>>>>>> should be declared as secure storage and optee should access that one only.
>>>>>
>>>>> Indeed, that would be an equivalent of tee-supplicant's --rpmb-cid.
>>>>>
>>>>>> Sumit, do you have suggestions for this ?
>>>>>
>>>>
>>>> I would suggest having an OP-TEE secure DT property that would provide
>>>> the RPMB CID which is allocated to the secure world.
>>>
>>> Another option is for OP-TEE to iterate over all RPMBs with a
>>> programmed key and test if the key OP-TEE would use works. That should
>>> avoid the problem of provisioning a device-unique secure DTB. I'd
>>> expect that the RPMB key is programmed by a trusted provisioning tool
>>> since allowing OP-TEE to program the RPMB key has never been secure,
>>> not unless the OP-TEE binary is rollback protected.
>>
>> +1 to that.  Overall we shound't 'trust' to do the programming. For
>> example, in OP-TEE if you compile it with device programming
>> capabilities, you can easily convince OP-TEE to send you the symmetric
>> key by swapping the supplicant with a malicious application.
>>
>
> Agree, with your overall intent, that OP-TEE shouldn't expose RPMB key
> in plain form. But with suggested OP-TEE RPMB frames routing via
> kernel, tee-supplicant won't be used for RPMB accesses.

do we plan to disable access to RPMB devices, once we have this RPMB 
driver in place. User space tools like mmc-utils/nvme/ufs utils
can still access RPMB and programme the key and should
RPMB driver deny access to RPMB ?
--656392-1544379424-1692731224=:12353--
