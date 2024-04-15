Return-Path: <linux-kernel+bounces-145872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DAB8A5C30
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9DA31C21A61
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF69156898;
	Mon, 15 Apr 2024 20:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="kHByMwUC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IueU6UZA"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C998E7EEE3;
	Mon, 15 Apr 2024 20:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713212850; cv=none; b=tEUpcojWQP5HeUkMaiQobXnm+liDkPL7G6KsyrwtTMRhScm/+BbcF+AGR+DL5cFXrPVThgUh6jeTeKMGQ0P+lFMgDTV8N2aKdfwlsbyzdZIBJk6JrRmqfgVqQEUy/SYU3fqHyL+Iok13DI36rY1PG2JFcPSK1PBqQvIUo8PShQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713212850; c=relaxed/simple;
	bh=mIsk5PxMpgJGxVIk8/AK0RH3ojqhs14Cpd+nHpxmtZA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=rpBuJgfoQKhImpgnndHgG4EkAV4PVfNlKHV5Ab0J2IvAfx50dPRN5Ajwr1g2mIHys45oShUk4qvVrPQoywikfEQZ/VaBU8EWPZ4/ZWluUQ0QPZiQIgWgX0fBjfb4uD/RFYTiunsUjZNIQ247lj+WPqar/xLu0M8uVF3pmfyJHG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=kHByMwUC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IueU6UZA; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C73CB1140156;
	Mon, 15 Apr 2024 16:27:26 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Mon, 15 Apr 2024 16:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713212846; x=1713299246; bh=xtZFpnMgm/
	+Xn/twFBJ7lG1+0rbINzM3+6AgqkcVRW8=; b=kHByMwUCnvXsVc4H9aV+eZa1Ya
	ZnkFc+5D9nWj/towPp62QKd8LURtw9QaamDTvbAG0SzFTXTfft2I9iw9jscCvYQ0
	mDYB/RWe4UW03Y/ZjdsdVGw6pCw6d3KxNONnVp/cnWP2nwmSQZ+Ec5ErLzjYNrPw
	FAwUqiABu6uYJ7LEHHJnZJfLuIKSUDWHGLyFxgHzoeIvwBvhTAouete00ZEGJUWS
	kd0axSVUGoeFN74hKCQQI1+XqNsaCVXkZ199EiCK9ZSNcvMSoqD4WcMLCNrE7kJg
	zSwPT8msXuFWdZza0lJTW7rE9rEZtVpwBycasFfcHCBPQzHshTNCxcV9Ocnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713212846; x=1713299246; bh=xtZFpnMgm/+Xn/twFBJ7lG1+0rbI
	NzM3+6AgqkcVRW8=; b=IueU6UZASUdsTNtGwH+tg9mj1KLB5fZkZSsaWXS/ZpjQ
	WC+wfN6frmzynTJH6njRVXy8sGIpywFeUr20kFcIZOkTCgdt+2x3mckP2mQlHh4A
	kIizTWDqZAPXwfBoeeGgASRK04pr3tBT4W/W1EGMO54kI1KcJ4vwj4ExH23LkhBW
	4ZFr11GUd48sBmx5zHKZOQj5HERXFwhl8TnRm61qKjGYLXsczgG3iV0KLnpH2jwP
	VtxVmr3yH69wlevHfZKmhOwn/tYd2b4dJLUxr9A1NgScfH+z4hz4jcwa0Vv3D5Z7
	MBK2eFEDYz5nBHU9NFcTNf/MXtmdmXd+2OJatn9nuw==
X-ME-Sender: <xms:ro0dZoLMGkef_9U5jovO-jhSP5rD8Fx0MV-LXgqoI3PC-zRhQUte9g>
    <xme:ro0dZoL78-Ubzj7B8QouBUdEqiEQ20sUUTJNM-O6_AiZ7GVyT_AN1C8fUnOrSWtNE
    Nr0NPOba2HSYs9Bzac>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejvddgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhepieeufeejieevteduvdekteefledtveffvedu
    hefffeejudefvdeijeegudegkefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgt
    rg
X-ME-Proxy: <xmx:ro0dZos6Eaz2z3-vzm9ZfZmz3Gtpx5hXWd4dqvSzJJOi2s5iXZf75Q>
    <xmx:ro0dZlY79oTHJE--S-v2JJvciO8HZCC53GejgZ4mWL7swt4bPii_PQ>
    <xmx:ro0dZvZLsllcnISD4rYL65NcHgfSJoA46v9Z4TLt1R48L9eYaJEKsQ>
    <xmx:ro0dZhD41zxCFb-Z6lStzI3xnGS3o9mOiIJJAIH6Ie6kaPCtqi3kLg>
    <xmx:ro0dZsTHu2ZNxKOKM-LKqwnhJUr35gkrRtv0bg_0SkyvTNB-QblqdRbG>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3D426C60097; Mon, 15 Apr 2024 16:27:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <539776c5-6243-464b-99ae-5b1b1fb40e4b@app.fastmail.com>
In-Reply-To: <Zh2G85df29tPP6OK@google.com>
References: <20240324210817.192033-2-mpearson-lenovo@squebb.ca>
 <ZhR-WPx7dgKxziMb@google.com>
 <f3342c0b-fb31-4323-aede-7fb02192cf44@redhat.com>
 <ZhW3Wbn4YSGFBgfS@google.com> <ZhXpZe1Gm5e4xP6r@google.com>
 <92ee5cb2-565e-413c-b968-81393a9211c4@app.fastmail.com>
 <ZhcogDESvZmUPEEf@google.com>
 <91593303-4a6a-49c9-87a0-bb6f72f512a1@app.fastmail.com>
 <Zh2CtKy1NfKfojzS@google.com>
 <484638e2-1565-454b-97f8-4fcc6514a69c@redhat.com>
 <Zh2G85df29tPP6OK@google.com>
Date: Mon, 15 Apr 2024 16:28:19 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Hans de Goede" <hdegoede@redhat.com>
Cc: "Peter Hutterer" <peter.hutterer@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
 ibm-acpi-devel@lists.sourceforge.net,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Nitin Joshi1" <njoshi1@lenovo.com>, "Vishnu Sankar" <vsankar@lenovo.com>
Subject: Re: [PATCH 1/4] Input: Add trackpoint doubletap and system debug info keycodes
Content-Type: text/plain

Hi

On Mon, Apr 15, 2024, at 3:58 PM, Dmitry Torokhov wrote:
> On Mon, Apr 15, 2024 at 09:50:37PM +0200, Hans de Goede wrote:
>> Hi,
>> 
>> On 4/15/24 9:40 PM, Dmitry Torokhov wrote:
>> > On Wed, Apr 10, 2024 at 10:48:10PM -0400, Mark Pearson wrote:
>> >>
>> >> I have a stronger preference to keep the KEY_DOUBLECLICK - that one seems less controversial as a genuine new input event.
>> > 
>> > Please see my response to Peter's letter. I think it very much depends
>> > on how it will be used (associated with the pointer or standalone as it
>> > is now).
>> > 
>> > For standalone application, recalling your statement that on Win you
>> > have this gesture invoke configuration utility I would argue for
>> > KEY_CONFIG for it.
>> 
>> KEY_CONFIG is already generated by Fn + F# on some ThinkPads to launch
>> the GNOME/KDE control center/panel and I believe that at least GNOME
>> comes with a default binding to map KEY_CONFIG to the control-center.
>
> Not KEY_CONTROLPANEL?
>
> Are there devices that use both Fn+# and the doubleclick? Would it be an
> acceptable behavior for the users to have them behave the same?
>
Catching up with the thread, thanks for all the comments.

For FN+N (originally KEY_DEBUG_SYS_INFO) the proposal was to now use KEY_VENDOR there. My conclusion was that this is targeting vendor specific functionality, and that was the closest fit, if a new keycode was not preferred.

For the doubletap (which is a unique input event - not related to the pointer) I would like to keep it as a new unique event. 

I think it's most likely use would be for control panel, but I don't think it should be limited to that. I can see it being useful if users are able to reconfigure it to launch something different (browser or music player maybe?), hence it would be best if it did not conflict with an existing keycode function. I also can't confirm it doesn't clash on existing or future systems - it's possible.

FWIW - I wouldn't be surprised with some of the new gaming systems we're seeing (Steamdeck, Legion-Go, etc), that a doubletap event on a joystick might be useful to have, if the HW supports it?

Mark

