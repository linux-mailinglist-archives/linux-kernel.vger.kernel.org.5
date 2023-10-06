Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D099C7BAFAB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 02:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjJFAmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 20:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjJFAmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 20:42:52 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE97D6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 17:42:50 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4181bd07f25so10024351cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 17:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1696552969; x=1697157769; darn=vger.kernel.org;
        h=in-reply-to:mime-version:user-agent:date:message-id:references:cc
         :to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=U9k+S0dqntQ7GutnlegbYwyjbLeCDxmQSNFEL6GQR48=;
        b=aQ1ujtn51cUqIpMLWxvPdRJNJ+5vFItdYSlXczyr0mLV/q/+5oGsZV0kpxuHszsP9J
         U94Dfl+SF5PuZGlYsAkUn9PljlekMUMMjBQbzfHH4Atr2OJBz7DayIHKtskiyg71HM55
         GgIMV3+6ubRyrwaI5cHkp1LDoHOrIZ8IHE4m4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696552969; x=1697157769;
        h=in-reply-to:mime-version:user-agent:date:message-id:references:cc
         :to:from:subject:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9k+S0dqntQ7GutnlegbYwyjbLeCDxmQSNFEL6GQR48=;
        b=Krb983jh5E5RcUAA8dDc5i1TwTb2utFdDUzY4whtzTLVbEUZUKU0TcI7Z48IGKpZC9
         okdkBqVsBv5wO/ESAUFTTJA39Ai6ULV4T/63zahdc9mYD3l7JQ3kJD4hkvm43xQSlRP4
         OPmJz8VcckEwMHquGQPpTbJpXmP9wzS4E0qCg90EqUnJ8XBiqsC5lc1TuGJsR7IjnEWo
         PfKZXIwLDiAosb/HtdBCrPLItVRgf33j7RMnY3wAVdgMH/XVpziNa1koToJHEpaT8SEE
         GmR0y2f71BBkC/eBR9hAnmo1bZolQ2BM/5xkS8m15Y5zcqvPj/cIEA5ivjX/1CBx2B3I
         CcWg==
X-Gm-Message-State: AOJu0YxqtJfpUFt/zjTQ7PteFMQc328mOXdj+0UKEgmqcxBMCfm85m3S
        JGFeSmFrd+pu6IlTwAR38hlJSw==
X-Google-Smtp-Source: AGHT+IHGj8o8sYpRZDbb8T4unR1Vtn9fHI9SaUOpsnCjCATM1lb9twScKP9F8+fxgpyfk2RW7K+kNQ==
X-Received: by 2002:ad4:5310:0:b0:653:5960:8959 with SMTP id y16-20020ad45310000000b0065359608959mr6265125qvr.41.1696552969187;
        Thu, 05 Oct 2023 17:42:49 -0700 (PDT)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id v14-20020a0c9c0e000000b006588bd29c7esm939982qve.28.2023.10.05.17.42.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Oct 2023 17:42:38 -0700 (PDT)
Subject: Re: [PATCH v2] mtd: rawnand: brcmnand: Initial exec_op implementation
From:   William Zhang <william.zhang@broadcom.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     dregan@mail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, f.fainelli@gmail.com,
        rafal@milecki.pl, joel.peshkin@broadcom.com,
        computersforpeace@gmail.com, dan.beygelman@broadcom.com,
        frieder.schrempf@kontron.de, linux-kernel@vger.kernel.org,
        vigneshr@ti.com, richard@nod.at, bbrezillon@kernel.org,
        kdasu.kdev@gmail.com
References: <trinity-bb7db9f1-d34d-4fe2-bed3-814d3a63476a-1694571881792@3c-app-mailcom-lxa03>
 <20230922162424.4a7b27ec@xps-13>
 <trinity-06dd34f4-ab26-4c60-bcf8-f986f1d08058-1696039055941@3c-app-mailcom-lxa04>
 <20231002143527.4ccf254a@xps-13>
 <04350e70-6ef0-4998-664f-20b96b63b0f4@broadcom.com>
 <20231003112819.53707d54@xps-13>
 <37416f2e-f150-cc8f-76bd-3d54f9e25d08@broadcom.com>
 <20231004005525.3f406823@xps-13>
 <0f6bd61c-19ed-8153-1763-eef2498726c7@broadcom.com>
Message-ID: <0c72dbb4-8ee5-c9b0-b029-9689e9d72f5e@broadcom.com>
Date:   Thu, 5 Oct 2023 17:42:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <0f6bd61c-19ed-8153-1763-eef2498726c7@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000179f1906070185ef"
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000179f1906070185ef
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Hi Miquel,

On 10/03/2023 09:47 PM, William Zhang wrote:
> 
> 
> On 10/03/2023 03:55 PM, Miquel Raynal wrote:
>> Hi William,
>>
>> william.zhang@broadcom.com wrote on Tue, 3 Oct 2023 11:46:25 -0700:
>>
>>> Hi Miquel,
>>>
>>> On 10/03/2023 02:28 AM, Miquel Raynal wrote:
>>>> Hi William,
>>>>
>>>> william.zhang@broadcom.com wrote on Mon, 2 Oct 2023 12:57:01 -0700:
>>>>> Hi Miquel,
>>>>>
>>>>> On 10/02/2023 05:35 AM, Miquel Raynal wrote:
>>>>>> Hi David,
>>>>>>
>>>>>> dregan@mail.com wrote on Sat, 30 Sep 2023 03:57:35 +0200:
>>>>>>     >>>> Initial exec_op implementation for Broadcom STB, 
>>>>>> Broadband and iProc SoC
>>>>>>> This adds exec_op and removes the legacy interface.
>>>>>>>
>>>>>>> Signed-off-by: David Regan <dregan@mail.com>
>>>>>>> Reviewed-by: William Zhang <william.zhang@broadcom.com>
>>>>>>>
>>>>>>> ---
>>>>>>>    >>>
>>>>>> ...
>>>>>>     >>>> +static int brcmnand_parser_exec_matched_op(struct 
>>>>>> nand_chip *chip,
>>>>>>> +                     const struct nand_subop *subop)
>>>>>>> +{
>>>>>>> +    struct brcmnand_host *host = nand_get_controller_data(chip);
>>>>>>> +    struct brcmnand_controller *ctrl = host->ctrl;
>>>>>>> +    struct mtd_info *mtd = nand_to_mtd(chip);
>>>>>>> +    const struct nand_op_instr *instr = &subop->instrs[0];
>>>>>>> +    unsigned int i;
>>>>>>> +    int ret = 0;
>>>>>>> +
>>>>>>> +    for (i = 0; i < subop->ninstrs; i++) {
>>>>>>> +        instr = &subop->instrs[i];
>>>>>>> +
>>>>>>> +        if ((instr->type == NAND_OP_CMD_INSTR) &&
>>>>>>> +            (instr->ctx.cmd.opcode == NAND_CMD_STATUS))
>>>>>>> +            ctrl->status_cmd = 1;
>>>>>>> +        else if (ctrl->status_cmd && (instr->type == 
>>>>>>> NAND_OP_DATA_IN_INSTR)) {
>>>>>>> +            /*
>>>>>>> +             * need to fake the nand device write protect 
>>>>>>> because nand_base does a
>>>>>>> +             * nand_check_wp which calls nand_status_op 
>>>>>>> NAND_CMD_STATUS which checks
>>>>>>> +             * that the nand is not write protected before an 
>>>>>>> operation starts.
>>>>>>> +             * The problem with this is it's done outside 
>>>>>>> exec_op so the nand is
>>>>>>> +             * write protected and this check will fail until 
>>>>>>> the write or erase
>>>>>>> +             * or write back operation actually happens where we 
>>>>>>> turn off wp.
>>>>>>> +             */
>>>>>>> +            u8 *in;
>>>>>>> +
>>>>>>> +            ctrl->status_cmd = 0;
>>>>>>> +
>>>>>>> +            instr = &subop->instrs[i];
>>>>>>> +            in = instr->ctx.data.buf.in;
>>>>>>> +            in[0] = brcmnand_status(host) | NAND_STATUS_WP; /* 
>>>>>>> hide WP status */
>>>>>>
>>>>>> I don't understand why you are faking the WP bit. If it's set,
>>>>>> brcmnand_status() should return it and you should not care about 
>>>>>> it. If
>>>>>> it's not however, can you please give me the path used when we have
>>>>>> this issue? Either we need to modify the core or we need to provide
>>>>>> additional helpers in this driver to circumvent the faulty path.
>>>>>
>>>>> The reason we have to hide wp status for status command is because
>>>>> nand_base calls nand_check_wp at the very beginning of write and erase
>>>>> function. This applies to both exec_op path and legacy path. With
>>>>> Broadcom nand controller and most of our board design using the WP pin
>>>>> and have it asserted by default, the nand_check_wp function will fail
>>>>> and write/erase aborts.  This workaround has been there before this
>>>>> exec_op patch.
>>>>>
>>>>> I agree it is ugly and better to be addressed in the nand base 
>>>>> code. And
>>>>> I understand Broadcom's WP approach may sound a bit over cautious 
>>>>> but we
>>>>> want to make sure no spurious erase/write can happen under any
>>>>> circumstance except software explicitly want to write and erase.  
>>>>> WP is
>>>>> standard nand chip pin and I think most the nand controller has that
>>>>> that pin in the design too but it is possible it is not used and
>>>>> bootloader can de-assert the pin and have a always-writable nand flash
>>>>> for linux. So maybe we can add nand controller dts option 
>>>>> "nand-use-wp".
>>>>> If this property exist and set to 1,  wp control is in use and nand
>>>>> driver need to control the pin on/ff as needed when doing write and
>>>>> erase function. Also nand base code should not call nand_check_wp when
>>>>> wp is in use. Then we can remove the faking WP status workaround.
>>>>>>     >>>> +        } else if (instr->type == NAND_OP_WAITRDY_INSTR) {
>>>>>>> +            ret = bcmnand_ctrl_poll_status(host, NAND_CTRL_RDY, 
>>>>>>> NAND_CTRL_RDY, 0);
>>>>>>> +            if (ctrl->wp_cmd) {
>>>>>>> +                ctrl->wp_cmd = 0;
>>>>>>> +                brcmnand_wp(mtd, 1);
>>>>>>
>>>>>> This ideally should disappear.
>>>>>>     >> Maybe we can have the destructive operation patch from Borris.
>>>>> Controller driver still need to assert/deassert the pin if it uses 
>>>>> nand
>>>>> wp feature but at least it does not need to guess the op code.
>>>>
>>>> Ah, yeah, I get it.
>>>>
>>>> Please be my guest, you can revive this patch series (might need light
>>>> tweaking, nothing big) and also take inspiration from it if necessary:
>>>> https://github.com/bbrezillon/linux/commit/e612e1f2c69a33ac5f2c91d13669f0f172d58717 
>>>>
>>>> https://github.com/bbrezillon/linux/commit/4ec6f8d8d83f5aaca5d1877f02d48da96d41fcba 
>>>>
>>>> https://github.com/bbrezillon/linux/commit/11b4acffd761c4928652d7028d19fcd6f45e4696 
>>>>
>>> Sure we will incorporate the destructive operation patch and provide a
>>> new revision.
>>>
>>> The WP status workaround will stay at least for this change. If you
>>> think my suggestion using a dts setting above is okay, we can provide a
>>> patch for that as well.  Or if you have any other idea or suggestion,
>>> we'd like to hear too.
>>
>> I thought this was not needed as Boris initial conversion did not need
>> it. The goal is to get rid of this workaround.
>> Boris' initial patch did remove that workaround but it will break the
> board that uses WP pin because the nand_check_wp run before the exec_op 
> and status returned is write-protected in the erase and write function.
> I explained that above and you can see the code here:
> https://elixir.bootlin.com/linux/v6.6-rc4/source/drivers/mtd/nand/raw/nand_base.c#L4599 
> 
> 
> I agree with your goal to remove this workaround and we have suggested
> one possible fix but we are also open to any other solution.
> 
We have integrated the destructive operation patch and are ready for the
v3.  If you don't think my proposal on the WP status fix is a good idea,
can we get this exce_op conversion patch series going first?  After all,
we don't modify the WP status handling behavior in this patch. We can
fix it in another patch whenever we agree on a solution.  Please let me
know and thanks a lot for all your comments and thoughts.

Thanks,
William

> 
>> Thanks,
>> Miquèl
>>

--000000000000179f1906070185ef
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
YDZuuBJwnyCzevMoPtVYPharioL5H3BRnQi8YoTXH7/uRo33dewYFm474yFjwwnt82TFtveVZkVq
6h4WIQ4wTcwFfET8zMkELnGzS5SHCl8sPD+lNxxJ1JDZYwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRp3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUq65GzwZxydFHjjYEU/9h
xHhPWlwwDQYJKoZIhvcNAQELBQADggEBAA2hGG3JPAdGPH0ZdohGUCIVjKz+U+EFuIDbS6A/5jqX
VhYAxZlzj7tSjUIM7G7IhyfqPC46GKJ/4x+Amz1Z6YxNGy71L68kYD6hIbBcA5AM42QBUufly6Oa
/ppSz3WoflVyFFQ5YXniZ+eU+2/cdnYZg4aVUnFjimOF5o3NfMLzOkhQNxbaDjFUfUYD8hKmU6v4
0vUBj8KZ9Gi1LIagLKUREn8jku0lcLsRbnJ5Ey5ScajC/FESPyYWasOW8j8/1EoJksmhbYGKNS6C
urb/KlmDGfVrIRYDbL0ckhGQIP5c6L+kSQZ2sHnQK0e0WgIaZYxaPYeY5u0GLCOze+3vyRMxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwxuh2XG3FXRL1W
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIK3JOz+4pfd/Fkcd9SHqLNkzl7JM
1lz4PiVVqnkyuarSMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MTAwNjAwNDI0OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBtxFeR2iijCbvLAHuwlMGYtpdcYDq9p1cYUmGqCNBTPl0l
y45RQRupYF8ZD1kjbF4aYFQgqGWS4Qq6bub86BkHsIZ3pr0HLiBHj3Ai5uf/JZswde+oitv337Yg
Rv7TXWvvlAKtHqw1GnT7FVgEGDbuP4gSRiN/DN2OAOiL+a9qgjV+hQLxL0vWL+NV49sANL2/7nWA
e/iiasOldRBK4T/jsX90j/+befJBxEhJsdjA9CEb7PDwpZE195A27d/Y5WE7h2WmMSuahddbtk6q
xhhc3I48TvEIxPK696zAaKQqOrTZphdGnooKLApvy9jn+DBVOhfMO4TalNXR0trcLeIL
--000000000000179f1906070185ef--
