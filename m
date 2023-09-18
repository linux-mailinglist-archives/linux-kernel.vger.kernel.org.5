Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5217A4E2A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjIRQII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjIRQHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:07:54 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BBB7AA0;
        Mon, 18 Sep 2023 09:05:54 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 91B645C01B3;
        Mon, 18 Sep 2023 11:23:37 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Mon, 18 Sep 2023 11:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1695050617; x=1695137017; bh=IF
        Ft4qfZvgojMpAkoGs0PF0vvgIAIXxSHXFESGsX9EM=; b=q5z3iMHYTZg5fy7F/b
        ywhcjZQtLsNj4WPOem5Hgf1Rw/BahVzedmXLPehbS6IvFJ/iDVO5U78XCsQI7zzB
        rwB7V5OIf8QtBDB9XDVtuZo2Sdxpr/BSucs8yRrpCsTFX4CwfUuoi5IB9yw1TJO3
        wp3ZgaXldVPr6ug5lG562nOyI+3ad0ZlyEf7JxnptoNh93fQYLKNhasXOdpImER9
        ruq0J9FRjcx8Dj2PpLtiPHvIJRTRaNiAfx5VI7qegpmn8Ce9w0EHXA+i5M+QPBht
        ULnHLtSJ9VHq9QkGgKm4ELdpLa2C3pfbpY+y3r5EN1JQox44HNlkocBQ6LBtPJoM
        /O1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695050617; x=1695137017; bh=IFFt4qfZvgojM
        pAkoGs0PF0vvgIAIXxSHXFESGsX9EM=; b=SnBYDAp6NQlaEnsoilrLa7ysmRqgy
        QStB76x3cPxL7rQ/Y7bgUKsXWPf/gSHtDWh/y1H+VMZLozu+E2mxzCvuJnm0XORk
        Fi/b5E7f+LjtqrSmVzutD3P39rnKEmXA9kqZ+VsrRYploD7mCFX9YDDJn92P02RS
        b7fjVzOwhvj3+V6+PTA1MUi8Hm/eUti2iAmNrFlfnNb8MhEBX/pYEjzFvfRC/GIX
        WP74lgoFytaL7eEyrSZRzYNTu76PFdUWji5uk0o4gTkvdlgYDcIXCkXnfJ+PPznF
        m66obm83W/eLzB6ba0pAEtsl9dw9YOtYU/vbqpHGZbFov7sKpU9AaHEnQ==
X-ME-Sender: <xms:eWsIZd3N1tquiYrF4HrZ9rlwW1S515pjJxae7TT7fQui_x2PB4AJYA>
    <xme:eWsIZUFRHOBCunsUxZpE83roRLb74fATNpCxsQiZbSxjv2b6ynaYKEnfLW0AYcpaw
    u0Wv8hZ0nOrgkACDsc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejkedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeiueefjeeiveetuddvkeetfeeltdevffevudeh
    ffefjedufedvieejgedugeekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:eWsIZd5WWxrGL_fcC5CiK0YWlYAuNX-2AtkkjNXcbeZ_mfghB7lCLg>
    <xmx:eWsIZa3ceiZGa5-grsniSvwT0xsaUrKbUnF2oCFwBt_tAzzgyjiZ8A>
    <xmx:eWsIZQEoU3beUSDovtvvOz7nry321svPbcg7yZZSoPHFD3J5lIWxkQ>
    <xmx:eWsIZVTUgAr1k-YfPWS-6gfo5CBQbi9mY3MtIpVC154nexpPhxYzTw>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 23F7EC60093; Mon, 18 Sep 2023 11:23:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <bf511687-8b29-42e2-92df-fcbf763cd3a2@app.fastmail.com>
In-Reply-To: <878da778-e183-6ef5-61ce-3a3d059f1a1e@redhat.com>
References: <mpearson-lenovo@squebb.ca>
 <20230906121328.50437-1-mpearson-lenovo@squebb.ca>
 <ZQhXZkBHviGOEl-x@smile.fi.intel.com>
 <878da778-e183-6ef5-61ce-3a3d059f1a1e@redhat.com>
Date:   Mon, 18 Sep 2023 11:23:16 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Hans de Goede" <hdegoede@redhat.com>,
        "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc:     "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: think-lmi: Add bulk save feature
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andy for the review

On Mon, Sep 18, 2023, at 10:07 AM, Hans de Goede wrote:
> Hi,
>
> On 9/18/23 15:57, Andy Shevchenko wrote:
>> On Wed, Sep 06, 2023 at 08:13:14AM -0400, Mark Pearson wrote:
>>> On Lenovo platforms there is a limitation in the number of times an
>>> attribute can be saved. This is an architectural limitation and it limits
>>> the number of attributes that can be modified to 48.
>>> A solution for this is instead of the attribute being saved after every
>>> modification allow a user to bulk set the attributes and then trigger a
>>> final save. This allows unlimited attributes.
>>>
>>> This patch introduces a save_settings attribute that can be configured to
>>> either single or bulk mode by the user.
>>> Single mode is the default but customers who want to avoid the 48
>>> attribute limit can enable bulk mode.
>>>
>>> Displaying the save_settings attribute will display the enabled mode.
>>>
>>> When in bulk mode writing 'save' to the save_settings attribute will
>>> trigger a save. Once this has been done a reboot is required before more
>>> attributes can be modified.
>> 
>> ...
>> 
>>> +Date:		August 2023
>>> +KernelVersion:	6.5
>> 
>> This is obviously incorrect (outdated) information.
>
> Mark can you please submit a follow up patch fixing this.

So I assume I put 6.6 in here? Or will it be 6.7?

>
>> 
>> ...
>> 
>>> +static const char * const save_mode_strings[] = {
>>> +	[TLMI_SAVE_SINGLE] = "single",
>>> +	[TLMI_SAVE_BULK] = "bulk",
>>> +	[TLMI_SAVE_SAVE] = "save"
>> 
>> Missing comma.
>
> Fixing this retro-actively is not really useful, if we
> ever need an extra entry we can deal with the churn then.

As I'm making other changes I assume I address this one too.

>
>> 
>>> +};
>> 
>> ...
>> 
>>> +static ssize_t save_settings_show(struct kobject *kobj, struct kobj_attribute *attr,
>>> +				  char *buf)
>>> +{
>>> +	/* Check that setting is valid */
>>> +	if (WARN_ON((tlmi_priv.save_mode < TLMI_SAVE_SINGLE) ||
>>> +		    (tlmi_priv.save_mode > TLMI_SAVE_BULK)))
>>> +		return -EIO;
>>> +	return sprintf(buf, "%s\n", save_mode_strings[tlmi_priv.save_mode]);
>> 
>> According to the documentation it must be sysfs_emit() if I'm not missing
>> anything here.
>
> Yes switching to sysfs_emit() here in the followup patch would be good.

Ack

>
>> 
>>> +}
>> 
>> ...
>> 
>>> +static ssize_t save_settings_store(struct kobject *kobj, struct kobj_attribute *attr,
>>> +				   const char *buf, size_t count)
>>> +{
>>> +	char *auth_str = NULL;
>>> +	int ret = 0;
>>> +	int cmd;
>>> +
>>> +	cmd = sysfs_match_string(save_mode_strings, buf);
>>> +
>>> +	/* Use lock in case multiple WMI operations needed */
>>> +	mutex_lock(&tlmi_mutex);
>>> +
>>> +	switch (cmd) {
>>> +	case TLMI_SAVE_SINGLE:
>>> +	case TLMI_SAVE_BULK:
>>> +		tlmi_priv.save_mode = cmd;
>>> +		goto out;
>>> +	case TLMI_SAVE_SAVE:
>>> +		/* Check if supported*/
>>> +		if ((!tlmi_priv.can_set_bios_settings) ||
>>> +		    (tlmi_priv.save_mode == TLMI_SAVE_SINGLE)) {
>>> +			ret = -EOPNOTSUPP;
>>> +			goto out;
>>> +		}
>>> +		/* Check there is actually something to save */
>>> +		if (!tlmi_priv.save_required) {
>>> +			ret = -ENOENT;
>>> +			goto out;
>>> +		}
>>> +		/* Check if certificate authentication is enabled and active */
>>> +		if (tlmi_priv.certificate_support && tlmi_priv.pwd_admin->cert_installed) {
>>> +			if (!tlmi_priv.pwd_admin->signature ||
>>> +			    !tlmi_priv.pwd_admin->save_signature) {
>>> +				ret = -EINVAL;
>>> +				goto out;
>>> +			}
>>> +			ret = tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
>>> +					       tlmi_priv.pwd_admin->save_signature);
>>> +			if (ret)
>>> +				goto out;
>>> +		} else if (tlmi_priv.opcode_support) {
>>> +			if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
>>> +				ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
>>> +							  tlmi_priv.pwd_admin->password);
>>> +				if (ret)
>>> +					goto out;
>>> +			}
>>> +			ret = tlmi_save_bios_settings("");
>>> +		} else { /* old non-opcode based authentication method (deprecated) */
>>> +			if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
>>> +				auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
>>> +						     tlmi_priv.pwd_admin->password,
>>> +						     encoding_options[tlmi_priv.pwd_admin->encoding],
>>> +						     tlmi_priv.pwd_admin->kbdlang);
>>> +				if (!auth_str) {
>>> +					ret = -ENOMEM;
>>> +					goto out;
>>> +				}
>>> +			}
>>> +
>>> +			if (auth_str)
>>> +				ret = tlmi_save_bios_settings(auth_str);
>>> +			else
>>> +				ret = tlmi_save_bios_settings("");
>>> +		}
>>> +		tlmi_priv.save_required = false;
>>> +		tlmi_priv.reboot_required = true;
>>> +
>>> +		if (!ret && !tlmi_priv.pending_changes) {
>>> +			tlmi_priv.pending_changes = true;
>>> +			/* let userland know it may need to check reboot pending again */
>>> +			kobject_uevent(&tlmi_priv.class_dev->kobj, KOBJ_CHANGE);
>>> +		}
>>> +		break;
>> 
>>> +	default:
>>> +		ret = -EINVAL;
>>> +	}
>> 
>> Missing break; and actually no need to do this part under the lock, besides
>> that it shadows an error code, that said this should be
>> 
>> 	cmd = sysfs_match_string(...);
>> 	if (cmd < 0)
>> 		return cmd;
>> 
>> 
>>> +out:
>>> +	mutex_unlock(&tlmi_mutex);
>>> +	kfree(auth_str);
>>> +	return ret ?: count;
>> 
>> You can switch the driver to use cleanup.h at some point.
>> 
>>> +}
>> 

Ack - thanks for the notes.

>> ...
>> 
>>> +/* There are a limit on the number of WMI operations you can do if you use
>>> + * the default implementation of saving on every set. This is due to a
>>> + * limitation in EFI variable space used.
>>> + * Have a 'bulk save' mode where you can manually trigger the save, and can
>>> + * therefore set unlimited variables - for users that need it.
>>> + */
>> 
>> /*
>>  * This is wrong multi-line comment style. This one
>>  * is used solely in net subsystem.
>>  */
>> 
>
> Good catch, Mark can you fix this one too please ?
>
Will do - not sure why I did that in the first place (it's a habit from a looong time ago that came back. Sigh).

Thanks!
Mark
