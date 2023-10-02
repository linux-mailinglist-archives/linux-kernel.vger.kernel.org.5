Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6D07B5BAA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjJBT5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjJBT5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:57:09 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675C093
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 12:57:06 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6c644a1845cso57871a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 12:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1696276625; x=1696881425; darn=vger.kernel.org;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=zgKSjspBXOwsqdpSwlUuRNuTEmrc/c8ro6svcmQ1xts=;
        b=Y2CzwD0lcVJc83/gdyq5fLDnqY0XZYnNGcGjRljKCNAqi1ACv2/U/PaDiriEt/Ovyp
         +1o+m0MDPsQ7mVKQyuW7YJHNVgZ4/jDKh1LR2tsU2vTastUGzK4NuJeQPFz87jcCXsOV
         G0nGCZAxxokb84FWdZD2Te8um5n1CloR39KBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696276625; x=1696881425;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgKSjspBXOwsqdpSwlUuRNuTEmrc/c8ro6svcmQ1xts=;
        b=Szg8GluzVcfuATXHeC+XG1Tpm0QSavkj/+peCjuzqxQu8l5GpPcBWpFkCBOJf5/3Jv
         ZwY37ZOnC6rYxHLHAsB5XLolYfNi1dKphe5fr8DJ3a2feL/HGuRYKExih/MiERHK0G3p
         yF7raeVtnJDYyK1zKRWqwmtBAL6m7AlsrAaQU+N/ye5ND2Q/A2rME6MuK8KGHHsfZ9Ng
         ShUaIiiwEqATiWvqFZaC8AcmC0yv8S52eyPljbQx7p+P+VsmDPJPjHxN6jvtREoP0QVt
         IrjjqENS2SRj+NBiAyGPv3GXxeD+dZmpLx2qof3DoWIhBhBPUEZDTHmK5ADcuqerTaQY
         jqaw==
X-Gm-Message-State: AOJu0YzG1FAMr58qvkSaEzfcvdvc4pREbF5qJD1Hv7BVIIiApRyXS+OR
        5sSid8LwJ80wDf+ha+CcLIUbfQ==
X-Google-Smtp-Source: AGHT+IFddapaYD7hcsIQHioTK/zniJpf4RjQeOiwzRR8d2tCou6T7lSOFJx1U2WdA6ODs/pP6RMFew==
X-Received: by 2002:a05:6358:785:b0:142:f9dd:5aa with SMTP id n5-20020a056358078500b00142f9dd05aamr14627568rwj.0.1696276625489;
        Mon, 02 Oct 2023 12:57:05 -0700 (PDT)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id u6-20020aa78386000000b00691037e04acsm15182479pfm.164.2023.10.02.12.57.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Oct 2023 12:57:03 -0700 (PDT)
Subject: Re: [PATCH v2] mtd: rawnand: brcmnand: Initial exec_op implementation
To:     Miquel Raynal <miquel.raynal@bootlin.com>, dregan@mail.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
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
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <04350e70-6ef0-4998-664f-20b96b63b0f4@broadcom.com>
Date:   Mon, 2 Oct 2023 12:57:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20231002143527.4ccf254a@xps-13>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000bae7e20606c12df7"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000bae7e20606c12df7
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Hi Miquel,

On 10/02/2023 05:35 AM, Miquel Raynal wrote:
> Hi David,
> 
> dregan@mail.com wrote on Sat, 30 Sep 2023 03:57:35 +0200:
> 
>> Initial exec_op implementation for Broadcom STB, Broadband and iProc SoC
>> This adds exec_op and removes the legacy interface.
>>
>> Signed-off-by: David Regan <dregan@mail.com>
>> Reviewed-by: William Zhang <william.zhang@broadcom.com>
>>
>> ---
>>
> 
> ...
> 
>> +static int brcmnand_parser_exec_matched_op(struct nand_chip *chip,
>> +					 const struct nand_subop *subop)
>> +{
>> +	struct brcmnand_host *host = nand_get_controller_data(chip);
>> +	struct brcmnand_controller *ctrl = host->ctrl;
>> +	struct mtd_info *mtd = nand_to_mtd(chip);
>> +	const struct nand_op_instr *instr = &subop->instrs[0];
>> +	unsigned int i;
>> +	int ret = 0;
>> +
>> +	for (i = 0; i < subop->ninstrs; i++) {
>> +		instr = &subop->instrs[i];
>> +
>> +		if ((instr->type == NAND_OP_CMD_INSTR) &&
>> +			(instr->ctx.cmd.opcode == NAND_CMD_STATUS))
>> +			ctrl->status_cmd = 1;
>> +		else if (ctrl->status_cmd && (instr->type == NAND_OP_DATA_IN_INSTR)) {
>> +			/*
>> +			 * need to fake the nand device write protect because nand_base does a
>> +			 * nand_check_wp which calls nand_status_op NAND_CMD_STATUS which checks
>> +			 * that the nand is not write protected before an operation starts.
>> +			 * The problem with this is it's done outside exec_op so the nand is
>> +			 * write protected and this check will fail until the write or erase
>> +			 * or write back operation actually happens where we turn off wp.
>> +			 */
>> +			u8 *in;
>> +
>> +			ctrl->status_cmd = 0;
>> +
>> +			instr = &subop->instrs[i];
>> +			in = instr->ctx.data.buf.in;
>> +			in[0] = brcmnand_status(host) | NAND_STATUS_WP; /* hide WP status */
> 
> I don't understand why you are faking the WP bit. If it's set,
> brcmnand_status() should return it and you should not care about it. If
> it's not however, can you please give me the path used when we have
> this issue? Either we need to modify the core or we need to provide
> additional helpers in this driver to circumvent the faulty path.

The reason we have to hide wp status for status command is because
nand_base calls nand_check_wp at the very beginning of write and erase
function. This applies to both exec_op path and legacy path. With
Broadcom nand controller and most of our board design using the WP pin
and have it asserted by default, the nand_check_wp function will fail
and write/erase aborts.  This workaround has been there before this
exec_op patch.

I agree it is ugly and better to be addressed in the nand base code. And
I understand Broadcom's WP approach may sound a bit over cautious but we
want to make sure no spurious erase/write can happen under any
circumstance except software explicitly want to write and erase.  WP is
standard nand chip pin and I think most the nand controller has that
that pin in the design too but it is possible it is not used and
bootloader can de-assert the pin and have a always-writable nand flash
for linux. So maybe we can add nand controller dts option "nand-use-wp".
If this property exist and set to 1,  wp control is in use and nand
driver need to control the pin on/ff as needed when doing write and
erase function. Also nand base code should not call nand_check_wp when
wp is in use. Then we can remove the faking WP status workaround.

> 
>> +		} else if (instr->type == NAND_OP_WAITRDY_INSTR) {
>> +			ret = bcmnand_ctrl_poll_status(host, NAND_CTRL_RDY, NAND_CTRL_RDY, 0);
>> +			if (ctrl->wp_cmd) {
>> +				ctrl->wp_cmd = 0;
>> +				brcmnand_wp(mtd, 1);
> 
> This ideally should disappear.
> 
Maybe we can have the destructive operation patch from Borris.
Controller driver still need to assert/deassert the pin if it uses nand
wp feature but at least it does not need to guess the op code.

>> +			}
>> +		} else { /* otherwise pass to low level implementation */
>> +			if ((instr->type == NAND_OP_CMD_INSTR) &&
>> +				(instr->ctx.cmd.opcode == NAND_CMD_RESET)) {
>> +				brcmnand_status(host);
>> +				ctrl->status_cmd = 0;
>> +				ctrl->wp_cmd = 0;
>> +				brcmnand_wp(mtd, 1);
> 
> Same
> 
>> +			}
>> +
>> +			if ((instr->type == NAND_OP_CMD_INSTR) &&
>> +				((instr->ctx.cmd.opcode == NAND_CMD_ERASE1) ||
>> +				(instr->ctx.cmd.opcode == NAND_CMD_SEQIN))) {
>> +				brcmnand_wp(mtd, 0);
>> +				ctrl->wp_cmd = 1;
> 
> Same
> 
>> +			}
>> +
>> +			ret = brcmnand_exec_instr(host, instr, i == (subop->ninstrs - 1));
>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
> 
> 
> 
> Thanks,
> Miquèl
> 

--000000000000bae7e20606c12df7
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEII5HpdPYE4rtX5EEiezJchSEBoh/
Wm8n2LVyC5k4ZxNYMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MTAwMjE5NTcwNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCJEBac+p+MNSZn5CuhTOs4Z2ufqpplOSOuLL1xIB2EcDdw
3tJYjJ7QpwOmw1QBR4sqFuX17f42ursxA05S/XWjSnBoxQykoTaDRcqcclG3M/er86MTcXfnUoO5
O0Xq5pj/HDJ538v/rB0mCYDWPdbmvjKYdmJQGF/j9SnBriposqiSpp+NarTHNzykOXSytoUGWQJA
a3Wax+bBVrn9yU+JFuVqpkZre6zWf3p8DJWZB+VNHu9UVuxt+KU0QS3omxLrvYgU2MEDyFsDobGe
balAz5AJgnAH/J8xz0WrLMEIPoOnhzjXcAj68CS8XP343rdC6OPDTYK8B/ut/p+voHTB
--000000000000bae7e20606c12df7--
