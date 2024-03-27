Return-Path: <linux-kernel+bounces-121828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF59088EE47
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E3E1C2F2D7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE8E14D6E0;
	Wed, 27 Mar 2024 18:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="CYUc2OW0"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C8114A634;
	Wed, 27 Mar 2024 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711564217; cv=none; b=aMknRbYVNJuxgLqJzkngK5rQD+nmqf9uOnBk2Vh+BqxE7xjnKEr/8/hWsXNV3RctLqK5RkdVyySRD0e8OOd+i9/ObOWyQQKCA7iIki9KUeR/LMJaz4yL2TNXxvBqjkZ/sAFLS7cWx1J56zHXqHgD8oPtTQ4EmbuP3ecdTWefWYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711564217; c=relaxed/simple;
	bh=0TKqOpubxbHl9foZydLNsR931Tn1b4JgToZMrqb2qYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txzPtDk7tjgDTW9gj2yeq++Vdfi0mjJ3OsK6NHQ3SxGUMiEnuVVh7NDk2NalNQmfCMMLa2W0vuc8xrYiw0J7I4FUDN1Ez+grQUBxCYTt3aW0GE0EL1XfIDB5mXdogysWoLy0QRw1b+9MLAGslESbiTJuQ3S1W6gg2A62oXX+EDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=CYUc2OW0; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1711564204;
	bh=0TKqOpubxbHl9foZydLNsR931Tn1b4JgToZMrqb2qYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CYUc2OW0X6Rl8GYW+v3Qev0z/IAJwmRzWttL8z3UOja0Y0it2bav0/a2Hmr5szkJG
	 SAd6/uJ5hNiSQGp/cqyQtCArmS7SPCyYbHYJRR15hzprGrkWjNt8pPQEauq0WjRrYC
	 CJRAJEW8V1IfZNvGFRn/GwO2eXtp45iLAMxn7V8Q=
Date: Wed, 27 Mar 2024 19:30:03 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] power: supply: test-power: implement charge_behaviour
 property
Message-ID: <8661d581-838d-4bcd-96df-2ae4b7572c82@t-8ch.de>
References: <20240306-power_supply-charge_behaviour_prop-v3-1-d04cf1f5f0af@weissschuh.net>
 <171148264419.185695.14027540198251584096.b4-ty@collabora.com>
 <6f0761a6-5f49-42e2-9b79-3e04c9d259a4@redhat.com>
 <9fe3d7a6-3b34-4c96-bd9f-510b41f9ab0d@redhat.com>
 <daactalkmzucga47cmncjkgnxyppouqnrj3vtsz34d5edrkmzu@p32ylpv3nqwx>
 <2e4f42b3-fe64-43f2-a55b-c745a6903ddc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e4f42b3-fe64-43f2-a55b-c745a6903ddc@redhat.com>

Hi,

On 2024-03-27 14:34:00+0100, Hans de Goede wrote:
> On 3/27/24 2:25 PM, Sebastian Reichel wrote:
> > Hello Hans,
> > 
> > On Wed, Mar 27, 2024 at 11:44:41AM +0100, Hans de Goede wrote:
> >> On 3/27/24 11:36 AM, Hans de Goede wrote:
> >>> On 3/26/24 8:50 PM, Sebastian Reichel wrote:
> >>>> On Wed, 06 Mar 2024 20:37:04 +0100, Thomas Weißschuh wrote:
> >>>>> To validate the special formatting of the "charge_behaviour" sysfs
> >>>>> property add it to the example driver.
> >>>>
> >>>> Applied, thanks!
> >>>>
> >>>> [1/1] power: supply: test-power: implement charge_behaviour property
> >>>>       commit: 070c1470ae24317e7b19bd3882b300b6d69922a4
> >>>
> >>> Does this mean that you've also applied patches 1-3 of:
> >>> "[PATCH v2 0/4] power: supply: core: align charge_behaviour format with docs" ?
> >>>
> >>> Because this is a new version of 4/4 of that series and I think
> >>> that the new test may depend on the fixes from patches 1-3
> >>> of that series (which I'm reviewing now).
> >>
> >> Ok, I have some not entirely trivial comments on patch 3/4 of that series.
> >> I guess you (Sebastian) could address those while merging, or wait for
> >> a v3 of the series.
> > 
> > I can't. Patches 1-3 are already in 6.9-rc1. It looks you did not
> > get my replies, but they certainly have been captured by lore and
> > obviously Thomas got them since he send a v3 with just the last
> > patch:
> > 
> > https://lore.kernel.org/all/20240303-power_supply-charge_behaviour_prop-v2-0-8ebb0a7c2409@weissschuh.net/
> > 
> > Anyways, I think your suggestions for further simplifications in
> > patch 3 are sensible. They just require doing an extra patch now
> > instead of being squashed.
> 
> Ah I see that is fine too :)
> 
> Thomas, can you do a follow-up patch with the simplifications
> which I suggested in my review of patch v2 3/4 ?

Will do!


Thomas

