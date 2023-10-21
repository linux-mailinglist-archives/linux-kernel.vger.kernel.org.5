Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0697D1FAC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 22:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjJUU4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 16:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUU4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 16:56:08 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA6E1A3;
        Sat, 21 Oct 2023 13:56:02 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 377D93200995;
        Sat, 21 Oct 2023 16:55:59 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Sat, 21 Oct 2023 16:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1697921758; x=1698008158; bh=i5
        0b4X8nAfPZABtna9BGpqBGkzaOmZqB3f12UN+ORdM=; b=VpK/fqtTPOiRmbbsr+
        vcgd7X/4963eUrqgVoGMsVVaUV5mhCIxBq8tIJYI8zbHQcIgaWEnN15FViO+KQe+
        ASszKBNnZce6eZA1h4lcKiEXSaEZs7zOSgitgM4zTzR3Hmn01Adt2OKmXQ9oYW9o
        d+D3v2H1q7dSXRn2yDUw6fGM7OxWRpmY+VVJ3rZW8F/e4LZ0XeIRUMLkVjS1wPlD
        u4doJjU7OuT2PBJaj1YDLo/7sgmaQUZfCHRWn1Y/HSEvPW3Kflj1vzTTsYfsH8hA
        zWis5gcNdXOvHpFpXPIe8UeMQXF0TDqwsvc1ZszjhzlYkocEP0u2TJO1Xwf876IE
        YMfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697921758; x=1698008158; bh=i50b4X8nAfPZA
        Btna9BGpqBGkzaOmZqB3f12UN+ORdM=; b=rBasE/89wXAspGcMdRP9ZeBV3Nbea
        C0GMp+7gyoiJFiV727faLmtyHObr9JRcFgrPp8PqFaQks7Yo6GMi2YdhRjRI8cva
        OKut8Zgx6GHbZHb2D5ObyrN/7HntYNSKS/SPY/oPOKfBhAZCRGV7mSHZeQu3Fa8Y
        fd7uDzP5J8TlK1jITQFPpC8l/8p208ncQDZaWmNZj34PByoG29rkB77PIveVxlLk
        PQMst0vrC63w9y31gnXtQS9UgbT1FH0zG3b5uWE7cgds1ygm+BbvRbc+YSMWznWQ
        xOYQ9xoXBKChjv5LBS/BewLEbaCaa/kzGIUaXYzkIeOjugUwMUCmBx5sQ==
X-ME-Sender: <xms:3To0ZZcIAyZExmOaYCVswLJVpzr461COVbSZxwOIU4s5nM8hMteiUA>
    <xme:3To0ZXNuLA6iWSCGf2u2Rl0ohdPEKBVz-nhC7Cb478mbGXEwH38_C284aAYw9ZlSO
    JLnzLCmDovaldtew0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkedtgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeehueeiieefiedutdduffffudevveevteehuedv
    vedtheevgeevkedvkeetueelfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgih
    hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:3To0ZSixincJXeZiVb7iDKFbuNO9NMI3BYKs-b5wK7CYua2Q-2TunQ>
    <xmx:3To0ZS_K-sbFry1iXiq_zI6zRcfcqDWiFRvij-4uKRDbkPrrth89Dw>
    <xmx:3To0ZVsUBmxEI-8tgQ_KRb7fxtUt4ljwj9EL16EXBdmF3HjC1SOHsA>
    <xmx:3jo0ZZjBr9yZJdRSN-SYXQLl88j0Xw3SvdBbp86KGFP-j_yEz7uXyA>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 65879C6008B; Sat, 21 Oct 2023 16:55:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <c0410813-d8cc-4609-92ba-ec41d107e99d@app.fastmail.com>
In-Reply-To: <20231020-strncpy-drivers-platform-x86-thinkpad_acpi-c-v1-1-312f2e33034f@google.com>
References: <20231020-strncpy-drivers-platform-x86-thinkpad_acpi-c-v1-1-312f2e33034f@google.com>
Date:   Sat, 21 Oct 2023 16:55:37 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Justin Stitt" <justinstitt@google.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
        "Hans de Goede" <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "markgross@kernel.org" <markgross@kernel.org>
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: replace deprecated strncpy with
 memcpy
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023, at 1:52 PM, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous
> interfaces.
>
> We expect ec_fw_string to be NUL-terminated based on its use with format
> strings in thinkpad_acpi.c:
> 11241 | pr_notice("ThinkPad firmware release %s doesn't match the known 
> patterns\n",
> 11242 |     ec_fw_string);
>
> Moreover, NUL-padding is not required since ec_fw_string is explicitly
> zero-initialized:
> 11185 | char ec_fw_string[18] = {0};
>
> When carefully copying bytes from one buffer to another in
> pre-determined blocks (like what's happening here with dmi_data):
>
> |       static void find_new_ec_fwstr(const struct dmi_header *dm, void 
> *private)
> |       {
> |       	char *ec_fw_string = (char *) private;
> |       	const char *dmi_data = (const char *)dm;
> |       	/*
> |       	 * ThinkPad Embedded Controller Program Table on newer models
> |       	 *
> |       	 * Offset |  Name                | Width  | Description
> |       	 * ----------------------------------------------------
> |       	 *  0x00  | Type                 | BYTE   | 0x8C
> |       	 *  0x01  | Length               | BYTE   |
> |       	 *  0x02  | Handle               | WORD   | Varies
> |       	 *  0x04  | Signature            | BYTEx6 | ASCII for "LENOVO"
> |       	 *  0x0A  | OEM struct offset    | BYTE   | 0x0B
> |       	 *  0x0B  | OEM struct number    | BYTE   | 0x07, for this 
> structure
> |       	 *  0x0C  | OEM struct revision  | BYTE   | 0x01, for this 
> format
> |       	 *  0x0D  | ECP version ID       | STR ID |
> |       	 *  0x0E  | ECP release date     | STR ID |
> |       	 */
> |
> |       	/* Return if data structure not match */
> |       	if (dm->type != 140 || dm->length < 0x0F ||
> |       	memcmp(dmi_data + 4, "LENOVO", 6) != 0 ||
> |       	dmi_data[0x0A] != 0x0B || dmi_data[0x0B] != 0x07 ||
> |       	dmi_data[0x0C] != 0x01)
> |       		return;
> |
> |       	/* fwstr is the first 8byte string  */
> |       	strncpy(ec_fw_string, dmi_data + 0x0F, 8);
>
> ... we shouldn't be using a C string api. Let's instead use memcpy() as
> this more properly relays the intended behavior.
>
> Do note that ec_fw_string will still end up being NUL-terminated since
> we are memcpy'ing only 8 bytes into a buffer full of 18 zeroes. There's
> still some trailing NUL-bytes there. To ensure this behavior, let's add
> a BUILD_BUG_ON checking the length leaves space for at least one
> trailing NUL-byte.
>
> Link: 
> https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings 
> [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
>
> Found with: $ rg "strncpy\("
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/thinkpad_acpi.c 
> b/drivers/platform/x86/thinkpad_acpi.c
> index 41584427dc32..bd9e06f5b860 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -11144,6 +11144,8 @@ static char __init tpacpi_parse_fw_id(const 
> char * const s,
>  	return '\0';
>  }
> 
> +#define EC_FW_STRING_LEN 18
> +
>  static void find_new_ec_fwstr(const struct dmi_header *dm, void 
> *private)
>  {
>  	char *ec_fw_string = (char *) private;
> @@ -11172,7 +11174,8 @@ static void find_new_ec_fwstr(const struct 
> dmi_header *dm, void *private)
>  		return;
> 
>  	/* fwstr is the first 8byte string  */
> -	strncpy(ec_fw_string, dmi_data + 0x0F, 8);
> +	BUILD_BUG_ON(EC_FW_STRING_LEN <= 8);
> +	memcpy(ec_fw_string, dmi_data + 0x0F, 8);
>  }
> 
>  /* returns 0 - probe ok, or < 0 - probe error.
> @@ -11182,7 +11185,7 @@ static int __must_check __init get_thinkpad_model_data(
>  						struct thinkpad_id_data *tp)
>  {
>  	const struct dmi_device *dev = NULL;
> -	char ec_fw_string[18] = {0};
> +	char ec_fw_string[EC_FW_STRING_LEN] = {0};
>  	char const *s;
>  	char t;
> 
>
> ---
> base-commit: dab3e01664eaddae965699f1fec776609db0ea9d
> change-id: 20231019-strncpy-drivers-platform-x86-thinkpad_acpi-c-7a733d087ef7
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>

Looks good to me.
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
