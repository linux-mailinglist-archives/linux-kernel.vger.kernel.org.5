Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05B97D1423
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377899AbjJTQgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjJTQgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:36:19 -0400
Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8CFD57
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 09:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1697819777; bh=8VUAv3B1Isg6MKeGEkZxQ1vzCh11D5OxMNtlylBo9Bc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=r5k0RKcGdHuK2FO9pc+UWZOZuNE1qJ6QQ3YU3DmXh4piPki3uQlGDUaZhJm6UIPbp7ktkXOzS/nJnankBHYXUmmLwfLNIYT1qRBi1HKHF/DiHILeLKVOfdzHQo0U8LBoVraNmvZxzVfi2LlYhVIOlPbayZ7UC6wCwzpfz018D1X8Wkvx4gmoG55eEkELMElDnbbaQrHYKipZiEoVLssgo2RS1HVBtSPsXAHamSJDXA/NEsxMlFOpDRC8ILsVykAVYWTgP7pgXbnWtscQiaczRbCJYNqtC91SqAHfQK5vNxWO7BT1QN1X6R2ZhG1wYot6qTzidq8OJlUzm8ZNvJOd+w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1697819777; bh=0ZB/dvXobrb/1h8Rhh4ke8J4D93KwC3Ua1J3Qljde7P=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=sIeS7ipQjc+Mir1lQqdbZjeCzVe+1KqjLbggtIVsoAqY5cLM7W92v8g3uJIeGZDSeml/uO0Eo7uJzIOF8HedvGNR88Jhem5TMjoXVXHPaiuilYT4t/YOVfrE5j8z3Qh2UjaeBqSGGkcTL+fetKCv4MZbLFY9DETtxjiAXyKad1TugPOe+IWmKcBjhbEXcsFzTge6X8czDYh4qR8C8BAm33f1Bp2uGj/Blfel6CMkWHvvVLBIrMdC/jFGd7QnyhKSOVwVXjfFmVlCPFAK7Y1Qq9aiYBKFdYEFopKmQcoYSqTl4pUdVHnJdCW7HcwgYhghSbmTgsWqz/MdhMXNrOQIOg==
X-YMail-OSG: RDZaU2IVM1n41Wv8sIw1y6UJGbGC6TCoqb7iD2xWQozSb_Vgy6L4TqbkJJ.LiUV
 Iv7osvv5uIy1i.5B.xjltXLLkx8IRc2upA7.jP1OdbcN_e44Rx0yu8DLQYwz4gtnV65cRHQcfvyC
 RsOzhjWQppB1wesjOaHbvTpfT9yPnR9NmQAinwTAsjh4I1qpC8cm2M1njah7YKLV.1GxLnlMxyKL
 MgUxRRM4Lu2VabVWTJYL747mP7dKtH_.0k4eWJyAqpX2ZcyZchtL5IeJiUx4Dv5dbtK6gd2JOG0Q
 sQdgG9Tn9JpSq_M24CzjLyFOrTswPRLu3coI5ESypC3BGOOgfe9y4n4XOdm004L1R7pXemZl6fV8
 e3DRG2zKWndT2tLBco3Ms6LSBNNFdIVeo88pTvlrzgbBOD.9EfOO39GFB3QiEFG55dJ7uCBcidzH
 CgCEvZgLiO2jIWTDT7P2y_pG2t3S54VRpeGDoDpaoKRutYD89N9KHPgfyg_Hw0lX1oEk1w96rsxh
 UanzRd4fcE8EG29941TesbhPDRs18rvkCXFptXwMH6nBufNpM5UxD69tRK4asH47dhyzFkzQFWjM
 g_UHl9t5rGxNokvpsX8vcqLSZOmowPyLd.pQjkDRaXwAw5DgivYiX5VYUkK9uXKNHlS8XXnXGHsz
 PbJDxNpsotsMhTt.K9SzXHk_eNy5_WXteurLMAVrULtBU6VQNsv1GswufevYPqV7X2am5kpnhQKF
 PpaTzH6Ef2M2NgwGGsCB0goSTcTptEEZ6mIxyX3_ZequaTbqlPLTiqEEqUfqmoDoZGuSjDI3FjN0
 cSy_C3205pbugq6D1P0e2AW5fTJgbyzG5iKaaMTLQLEQIhZ1Kfh9yaftJhn8k8HhPcgeC3Lh3b68
 hwq_A6r.NqNXB6qngZuiGh8AZJrgexOk2BOX9TXjoIshTK5xhi3AMNpYuZ4kZ9HVlm8wYQpjdLCK
 QSjkCkpbotPtAJNshC.I4FHtp.Ivewu2wHkIChjfPujHG9Fd69FtImPCE_8QdLLQR6LPeqmxNpZ2
 OJhRLpXabUCvWjEOkfUkgjJFY3kfQpSbbdkGmH8X8B8ki_eiK6hgfYXsVJwMic8qxaAqJCgqhHsT
 xv3Q8OSxVZrqYwj5Lmk3idO4eNQKQSl.hQSSnFM3rbXx5AjgQfg_qIB_n7HaN9K6yFWgkcRU2Scm
 p.BseoG62O1PJBOu7x3LOzFMp3WaELbPWDeAKQVpidUm0LfbNwprolj0agBYv1ts05TfSHDVYbxP
 szzUhxIe0VO8AQsGI0rYLTOlbL4KPdmU9yB9rSoA4n6X7ehF5ufKR6brvBHM1ZPqh7bOsOs37mqJ
 1.oQ3WY_yfRYD5KQopTY6gciTFS5.v47c4T0xPqTZw4sJ7Cfl4YkeCoVOa4OpmKb.2REd8P3Iz5s
 usDMEPe3ZxIHOH3IDFSZ8QcBwu06icq5T1LWPZAC.2nKF6wGL_qIHVZoExuOeqIUlLV.wfPycLyb
 IdbWBrhN3D9p6erB8ZAWGjR8Cp6E05mRA7Xni.UT6LoHYRUA2jd3iE3B9zIm0rgJf3byWKHynJzc
 bFdnDPo9meEhnoShEcyZWY_Jn9x6NLrcKra35iKbIHwSF4R.5Zzg7BNKyi2tKYn1CjZFeJNeXwx1
 Vprj.JWQfD7FJoux6H2pBky0XNcpyk9Y1ueFeywoHhNgPFDWONXEXh3Njwqpza4V38OuzSLGVxZJ
 AXIFMMivD_GNn1ZIIkgs2AAV_7FzUoUmSFPBFBNs8hYDIWfIC6WJ.GjjfoxP_8DR4CQcRS8wXNGR
 Eqdg1JIMo5SMPC.kvmdT5e8V73iYXLITDkQitE.YzUCKS9qDUlvrA3OdKTGibkLSfXkPg35Wcnii
 bAT30G5__XSQkD3m82tdJtJNJdyPNO70hrSQ2CcfDpgiaA_3a03zWl2leSDKA1x4ybvd7yACSD9H
 YZH2Y2PNOb8QSuNEncMnacAxumI2uenhH4whLhIjyAXEkcpdckf018X_qWVostN8dexWexvfczmG
 Aab5rU5Yb6VkYn6DH939lB5_7GL9etV3EOvPBsqutDgN5LecFJrEDkGZwU0NQ_dUn5o4EJ6mivIY
 hSE7h2kIZzDMqhJ1ItjjSiOb8k.ChF0zqqRfCCKP9KOaky06Fw3fvET9o.DEp6ThVjd6lgodNLm0
 f7Mc6k4iyDiKMzCKFiIUI.H_hq7opxjoo7ChG1yI3tAqFr7gTo6afSvU5SaAP9qrNEB7SHfQZ4MK
 IX06TzoMUTKQlp4WE6DLS9C5VHQfzZgsVDykPGElZwa8QQDla9A3o7aRPGC65i8QckvT3Z0duXIW
 F8sYHhzelVD.NGiE-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: da1684e5-5c62-460a-97c6-d0ef1043aa9f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 20 Oct 2023 16:36:17 +0000
Received: by hermes--production-ne1-68668bc7f7-bjk24 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 81c233cec5c2721208e7bbfbac96bdf8;
          Fri, 20 Oct 2023 16:36:15 +0000 (UTC)
Message-ID: <5c942750-3383-47bc-8326-3ed173ebfe8f@schaufler-ca.com>
Date:   Fri, 20 Oct 2023 09:36:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 00/11] LSM: Three basic syscalls
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Paul Moore <paul@paul-moore.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        linux-integrity@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230912205658.3432-1-casey.ref@schaufler-ca.com>
 <CAHC9VhRcbp3iWQwL7FTUrcU1C3OsZ413Nbq+17oTwW7hZ7XvBw@mail.gmail.com>
 <CAHC9VhSqY5+DR-jXprrftb1=CzDvhTh0Ep66A16RMd4L7W7TYw@mail.gmail.com>
 <ae39864947debbc7c460db478b8abe1c147b7d5c.camel@huaweicloud.com>
 <CAHC9VhRQ7xpeSX7b3VZfzQ15noJ8mgauNMuHWo_n3hMgsYMAfQ@mail.gmail.com>
 <468436cf766732a3cfc55d07ad119a6ccdc815c1.camel@huaweicloud.com>
 <CAHC9VhTjHT-DGKu0=cZPVb=+kMwmbPdr8HiVWJq-yzaDiYk_SA@mail.gmail.com>
 <6f33144c850c40e9438a6de2cf3004e223508755.camel@huaweicloud.com>
 <2637d5294d4a7ae871f1b758f5a30234836e2463.camel@huaweicloud.com>
 <c896c8ed559d0075146070be232e449b6951eb99.camel@linux.ibm.com>
 <283bf52d-af6e-4d20-a5ba-d98511c2e530@huaweicloud.com>
 <CAHC9VhSiUgY1Dzy6LGOjPF6XQ3pVBiZ9LPdcQANNXZ9rj-WURw@mail.gmail.com>
 <80f05011bf9fe19bde1f923e98c2db69ffc91065.camel@linux.ibm.com>
 <CAHC9VhSqgAD09QL2n0aoWLK7RGPkkjZHBrDCQmt1p3=ozpdt4A@mail.gmail.com>
 <e12f63037405f41a1be979b1424d1404d3139a4d.camel@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <e12f63037405f41a1be979b1424d1404d3139a4d.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/2023 12:45 AM, Roberto Sassu wrote:
> On Wed, 2023-10-18 at 16:40 -0400, Paul Moore wrote:
>> On Wed, Oct 18, 2023 at 4:23 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>>> On Wed, 2023-10-18 at 12:35 -0400, Paul Moore wrote:
>>>> On Wed, Oct 18, 2023 at 10:15 AM Roberto Sassu
>>>> <roberto.sassu@huaweicloud.com> wrote:
>>>>> On 10/18/2023 3:09 PM, Mimi Zohar wrote:
>>>> ...
>>>>
>>>>>> I agree with Roberto.  All three should be defined: LSM_ID_INTEGRITY,
>>>>>> LSM_ID_IMA, LSM_ID_EVM.
>>>>> I did not try yet, but the 'integrity' LSM does not need an LSM ID. With
>>>>> the last version adding hooks to 'ima' or 'evm', it should be sufficient
>>>>> to keep DEFINE_LSM(integrity) with the request to store a pointer in the
>>>>> security blob (even the init function can be a dummy function).
>>>> First off, this *really* should have been brought up way, way, *way*
>>>> before now.  This patchset has been discussed for months, and bringing
>>>> up concerns in the eleventh hour is borderline rude.
>>> As everyone knows IMA and EVM are not LSMs at this point.
>> Considering all the work Roberto has been doing to make that happen,
>> not to mention the discussions we've had on this topic, that's an
>> awfully small technicality to use as the basis of an argument.
> Sorry Paul, but I've been working on this patch set for a long time and
> you were also involved in the prerequisites (like making the
> 'integrity' LSM as the last).
>
> I thought it was clear at this point that we were going to add the
> hooks to the 'integrity' LSM.

There's a chicken/egg issue here. You can hold up the syscalls patch
forever if you insist on it accommodating every patch set that's in the
pipeline. I understand that you've been working on the integrity rework
for some time. I understand that it's frustrating when things change out
from under you. Believe me, I do.

>
> I really have no problem to rebase my work on top of other work, but I
> was very surprised to see LSM_ID_IMA instead of LSM_ID_INTEGRITY, and
> at minimum this should have been agreed with Mimi. And also, I was not
> convinced with the argument that LSM_ID_IMA should represent IMA+EVM.
>
> Roberto
>
