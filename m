Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C3478D215
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 04:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241708AbjH3C3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 22:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241707AbjH3C2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 22:28:44 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5071483
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 19:28:40 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id EA23B32009A3;
        Tue, 29 Aug 2023 22:28:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 29 Aug 2023 22:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1693362515; x=1693448915; bh=1E
        DY2NQiLlXzc7YlNTpLWctDA9Pad08qbCtx6qCAsrQ=; b=KFDiA98iz/meA5dCsQ
        QU0NbYxxOIuT5Y5Wl8tRogqhQn3XUl9T7o4+MhMWkOoLAGF6WO0FJvb38U62xWOk
        l3YjP6+ey/kP4i+yH9QEJJYQfnM379cjWI54kVhdW6cgDl5niCmqYjsQ+ASJOw3J
        jJ2XS14HkPJlGpXZb4PecxykhDf6lSOtvmLJPwlR5O1zaU08EzNbid2nwhAI8Jau
        Rzy6DBujPeNKdKHwdbV9yLP0v/QqV5gn1f5X0ixkQADH+R6D2V20jfll5vheDti7
        O51jNvCqf1LxbKAR1MfAIPifv8dphOk/Yr/it/aIRwMDAv53BbutTnE6Obq0/72z
        E+uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693362515; x=1693448915; bh=1EDY2NQiLlXzc
        7YlNTpLWctDA9Pad08qbCtx6qCAsrQ=; b=GUSPIvKjPJgd1S3J9IalAV5iYFArY
        JLwf4HokWeG5WAyScCKTebW6qgjZ6/V4Sn3Y1wjYxFDjVWb+yHr9JNy0DAD0VmsB
        dj8auB+uz0NAke5Aef+AEh0earmXiCTbQNnhpuWCzj/EY7w69z/j+ODZMBwJD/Kr
        BTsTWPpRinXDxE/YfUBJG2zq4lG6ZH87yfImmnw0FxypiiOunI2xGhDcaDGt3mTE
        NYpVz9tMBwXQE1Q+WjmgSxbWu4m3enWH2YBNqU+QO73qBzUf7WqhKEcy/hRtDaXM
        bhatwmDmah1e/0grS3K1vSz4tSKflwQo/KQxVwG+QsnV+b39hVODSWNRw==
X-ME-Sender: <xms:U6nuZLv63h3ucPoyUibvm1gFmFO1ik2Qm7fizycwbeWXpDUniXlLsQ>
    <xme:U6nuZMffjqML2mbIfYvdOWKlHrqjK6oP4pjcpU9sqZr49jHblWlYMryNPi4Nbd96w
    E9B2FxN_4vNoi_vTfs>
X-ME-Received: <xmr:U6nuZOxpttWWcY6nfW7j4E_frQw6e4-aFLW2fKsX8mx8_CQsv8KzdCSmyBsXEj1FLoBmjoYB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefjedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    ephfeigedtveefjeeukeetfeektdeffeefteekfeffieeiteeigeehhfdutdeitdehnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:U6nuZKONSHRfYzLug43BJCMnzOqFy4EnfN1UaIxx8H-_wS_MZZHIMw>
    <xmx:U6nuZL-ErNr7sYHcSFA2gSqr2TSYvwFQdNNenBk5Uu-Z05X4lQ83QA>
    <xmx:U6nuZKW7sp1-RuDaYSlma_FnFZv2eQuUo4wJvyfBLdEejtdnB34wKQ>
    <xmx:U6nuZFmKON6GKWfv8tH_hZBZYK4lvcpBS9bTDVCv8V1cToLS9U3rWw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Aug 2023 22:28:32 -0400 (EDT)
Date:   Wed, 30 Aug 2023 14:28:18 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH] platform/x86: asus-wmi: corrections to egpu safety check
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     corentin.chary@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <6VM60S.XT1JR051MC8P1@ljones.dev>
In-Reply-To: <32942803-b0b9-ddcd-90f7-1fc37062a18f@redhat.com>
References: <20230827231525.78693-1-luke@ljones.dev>
        <32942803-b0b9-ddcd-90f7-1fc37062a18f@redhat.com>
X-Mailer: geary/44.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Aug 28 2023 at 11:58:51 AM +02:00:00, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi Luke,
> 
> On 8/28/23 01:15, Luke D. Jones wrote:
>>  An incorrect if statement was preventing the enablement of the egpu.
>> 
>>  Fixes: 1bddf53ccac0 ("platform/x86: asus-wmi: don't allow eGPU 
>> switching if eGPU not connected")
>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
> 
> Not sure which tree/branch this is based on but the commit-id for 
> your Fixes:
> is not correct.
> 
> in my tree this is commit d49f4d1a30ac (platform/x86: asus-wmi: don't 
> allow
> eGPU switching if eGPU not connected") .
> 
> 
> 
>>  ---
>>   drivers/platform/x86/asus-wmi.c | 15 +++++++--------
>>   1 file changed, 7 insertions(+), 8 deletions(-)
>> 
>>  diff --git a/drivers/platform/x86/asus-wmi.c 
>> b/drivers/platform/x86/asus-wmi.c
>>  index 6db2d18a61e0..b51586986450 100644
>>  --- a/drivers/platform/x86/asus-wmi.c
>>  +++ b/drivers/platform/x86/asus-wmi.c
>>  @@ -731,19 +731,18 @@ static ssize_t egpu_enable_store(struct 
>> device *dev,
>>   		return -EINVAL;
>> 
>>   	result = asus_wmi_get_devstate_simple(asus, 
>> ASUS_WMI_DEVID_EGPU_CONNECTED);
> 
> And this does not apply, because the:
> 
> 	result = asus_wmi_get_devstate_simple()
> 
> you have here has been fixed in my tree to be
> 
> 	err = asus_wmi_get_devstate_simple()
> 

Fixed.

> to match the error checks below which actually check "err" not 
> "result"
> I guess that a fix for this being squashed into my tree is also what
> has resulted in the different commit ids.
> 
> Please rebase on top of:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next
> 
> and submit a new version.
> 
> And please also Cc: platform-driver-x86@vger.kernel.org for the next 
> version.

Thank you for the review Hans.

> 
>>  -	if (err < 0)
>>  -		return err;
>>  -	if (err < 1) {
>>  -		err = -ENODEV;
>>  -		pr_warn("Failed to set egpu disable: %d\n", err);
>>  +	if (err < 0) {
>>  +		pr_warn("Failed to get egpu connection status: %d\n", err);
>>   		return err;
>>   	}
>> 
>>   	if (asus->gpu_mux_mode_available) {
>>   		result = asus_wmi_get_devstate_simple(asus, 
>> ASUS_WMI_DEVID_GPU_MUX);
>>  -		if (result < 0)
>>  +		if (result < 0) {
>>   			/* An error here may signal greater failure of GPU handling */
>>  +			pr_warn("Failed to get gpu mux status: %d\n", err);
>>   			return result;
>>  +		}
>>   		if (!result && enable) {
>>   			err = -ENODEV;
>>   			pr_warn("Can not enable eGPU when the MUX is in dGPU mode: 
>> %d\n", err);
>>  @@ -753,12 +752,12 @@ static ssize_t egpu_enable_store(struct 
>> device *dev,
>> 
>>   	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_EGPU, enable, &result);
>>   	if (err) {
>>  -		pr_warn("Failed to set egpu disable: %d\n", err);
>>  +		pr_warn("Failed to set egpu state: %d\n", err);
>>   		return err;
>>   	}
>> 
>>   	if (result > 1) {
>>  -		pr_warn("Failed to set egpu disable (retval): 0x%x\n", result);
>>  +		pr_warn("Failed to set egpu state (retval): 0x%x\n", result);
>>   		return -EIO;
>>   	}
>> 
> 


