Return-Path: <linux-kernel+bounces-74971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A63B485E097
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ACDD28388D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E1A7FBCE;
	Wed, 21 Feb 2024 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFb9kODK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201F67FBBE;
	Wed, 21 Feb 2024 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528284; cv=none; b=QPZo2KbEiYK1ta9hjlZlv04zmFnHcMp1hcXmJGjU1xyb+6CqvieAlUsI4hmhu3a9fGbvQ56VMf3lgQgSDodjLRDoL21VKG0vb0iUmEOxQpu60sVl9Gs4B1X9w397WafkntaQqxvYMawOaQfHW7ubS3ydMe43xrE10kVwGjhNwGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528284; c=relaxed/simple;
	bh=V3rx40g1STRWZDKkvNSWNApiqJ5slnh/SwoKz8ZnGbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8bfeg0wTt4Z5NSZzyp5DuAMoVcMpVXtY+v+7ZFnpg6SUm4zpphljSIRM4JMeUJmXMmth0gOT25k/NCUZXYT+mT443T7NLdsLlPY/R6kvvXMiCm82s6Nk1+xwq+N0hwEs4jG11QRxiQ8k7vVYBKgKslQ6v0bVnfvrjg03Lc9Uo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFb9kODK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E471C433F1;
	Wed, 21 Feb 2024 15:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708528283;
	bh=V3rx40g1STRWZDKkvNSWNApiqJ5slnh/SwoKz8ZnGbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FFb9kODKb2azoLm5xC3zKfnxwGOW3yK3gI7IuV7WCJlEaXeSGjAewhOBLM1iCin8G
	 Fc/qdpwQRj/hB9rASdiBkOs+IqZ6pln0zOLAKwW0iXSMfGdMuC51KsNHj0DmYOWCdb
	 voI2Qmn+HPpKvg9Q6r8gpyDfqhd6KIpOXFLxDyhNWDKZTIVzKx3E+lygO/4qh79NAJ
	 vPGtYNklUvouUpWbBSeKED/1944D1qwjpa0bLvvIOQ3yaF0VLPics6YadjJS6dRR6+
	 TKsblHsZ7N/H3qgSPbWgqxBACUHvjPxOR+LXfTJpi//nrUqurA1WzbduzblaHOj829
	 9LlHx9QdX/0EQ==
Date: Wed, 21 Feb 2024 10:11:21 -0500
From: Sasha Levin <sashal@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: cve@kernel.org, linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52437: Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING
 in raid5d"
Message-ID: <ZdYSmdUKzQAYpprc@sashalap>
References: <2024022009-subsoil-halt-4b28@gregkh>
 <7ae646b3-28e4-4344-a7a4-730a0d6e3f38@redhat.com>
 <CABgObfYDcFPRNpGtsY=UbstXbqVCMcxy3LPS_xJ65aFcByC=Nw@mail.gmail.com>
 <ZdXt09vL4GJy6PbP@sashalap>
 <0e8675e0-165d-4cf7-9755-666278868ab8@redhat.com>
 <ZdX2LcAWR6wyvYC5@sashalap>
 <bec7c1db-c13e-4b00-a968-4ae69539d7ac@redhat.com>
 <ZdYKSkqRckOc5aRO@sashalap>
 <a9652aa2-e79b-4144-b3b7-746587af9eca@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a9652aa2-e79b-4144-b3b7-746587af9eca@redhat.com>

On Wed, Feb 21, 2024 at 04:02:45PM +0100, Paolo Bonzini wrote:
>On 2/21/24 15:35, Sasha Levin wrote:
>>On Wed, Feb 21, 2024 at 02:15:12PM +0100, Paolo Bonzini wrote:
>>>>On 2/21/24 14:10, Sasha Levin wrote:
>>>>>On Wed, Feb 21, 2024 at 01:58:04PM +0100, Paolo Bonzini wrote:
>>>>>>On 2/21/24 13:34, Sasha Levin wrote:
>>>>>>>[snip]
>>>
>>>This conversation needs to be public.
>>
>>I've cc'ed lkml.
>
>This is an empty message, so it's not going to help making public the 
>part of the discussion that was CC'd to the moderator-only list.  I 
>take it that I can quote any part of the private thread?  I'd like to 
>have your explicit permission for that, if you are not going to resend 
>your answer.

Please do. Sorry - trying to do this before my morning coffee...

-- 
Thanks,
Sasha

