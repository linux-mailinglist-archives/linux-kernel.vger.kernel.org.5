Return-Path: <linux-kernel+bounces-145985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F558A5DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B792834AE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A9915885C;
	Mon, 15 Apr 2024 22:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtwQ8J4u"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4895158856;
	Mon, 15 Apr 2024 22:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713221696; cv=none; b=ZEkjt/fI/bOLzbndmqayS4KPw5343UYhTEC/QnuS/F3AR65YAPLZIW3kAAMN0jChjUBzLDNq/CMKzlChswARZCLurQdQ0iNIBiL+7NOe/F5OF3CkaszjY67jq4mepefeExXPgr2bKhz6So7Z528SlB/shA48PpWxRpqtQ+U1+94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713221696; c=relaxed/simple;
	bh=Y/s6gxAhSIDQI8G7l/+6Qgj0UdQHTwKGgOtagcLo+oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6sTQ6N8gonvLOYXWiFBgi0tcDW/lvJHpbN05BrdfyLQvi/oXLHBVyDLvZkMYzIxF+9yAs0Nve2P17STyM9PqJYxfKUFT0TrY7Yy25nsZzAGnyPv1TchBj0QuxiDWYQmFWRla0n7+dnNoWzDhBajVKiwcg9yIc2CrqefiiF0WSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtwQ8J4u; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e5c7d087e1so22473075ad.0;
        Mon, 15 Apr 2024 15:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713221694; x=1713826494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WsNr1h6wQ6+rX+nY8lyqGTb0yfOPxHbOIqfkCkSOqNw=;
        b=GtwQ8J4uPNciDGrLbIPIBKk1uTgJ+7nUZvxZFlJN0goHpa1F6ig9E80GdEzn4cDgpx
         Dhw0qD+0qP1OUwDeKraoBLHz8Ea6HoGsIf7aW7mXPQ2x2+Udn0aFwUAOlPIhfS+X26J9
         ZzdcDwle9BDlnzaUxKOCWTSqXirNe3ihPe0tYYrhvBYHfKJFzJHbaWd9Pi5uLKT1nZ1i
         MkPkKsvq6IKizJMGrCN31070EZZDK91mrwx0MmKaxCtHa3tieS/6RHfHZBbbB0iE8UGj
         K4i7Qb47DnWY99YeowtWLH9LkkMMiKKnPGMkNLMU5F0ACSQn4K+g4aj0V3EqVOAl66QU
         bfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713221694; x=1713826494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsNr1h6wQ6+rX+nY8lyqGTb0yfOPxHbOIqfkCkSOqNw=;
        b=geMaJYqEWtd0WPgGlrhXvubqAYb0b6bjXTOleHRRj94nITZc3gqaCcZYM6A1ahUsE9
         RHQhTmBx//iHQUV85gB4eMw2qwoyu+H+fs401CpOJK5O0NaNmWdU5VR26hRcJjO/g9iT
         XoQ19UUecdRbwrsCU6k+oTj9G82WwBsjqQeCnIySjd8e/m5noZZh5Y3TKxZhU/QRl+3F
         aisWdrLeJ+/ktAfUl8dT1JNtqxs7BvKXA/5INxOYvVDbQmYQjC+srzO7z/d3himv79nF
         2lOMB1/G260VmnrxVBUl2KWcFJfnu2Ao5WOIcOWJuyGpFVaQedFgE9YSOmHSkwwl4rfa
         3vIw==
X-Forwarded-Encrypted: i=1; AJvYcCVzhESqmd+IIrmYaWmkIJA+dJ2e6rbWlfsvdUv+BzTEvz+7EtqD86InYAoSaUyRLlFf7+yfSkZ+/8CMJqzwZkglQkYxxJKBn5jprnzaQYrHCqpv/Yks4TMYT4A9uIbWfhLnZYP8AkjSbPHGSQoWPgS0Erg2ylTbuh8oQDteMDwQeqGL8QDVQqfEWD5ND7pX
X-Gm-Message-State: AOJu0YyVqiL6ahfJLtx+e7kqhoI2yalFpMrAVdxn0UAtI58l1vFWT7+Y
	HuDYfNR9OOo72xsStSYPAEPa99GJE1DNfj/Au7dm7QF/9XBBKVt5
X-Google-Smtp-Source: AGHT+IG0yCx4JCIkc1/JHWIUJZJksqByKLnZQ07Sm2LAI6p/FZsVKHr2qXc32SSlbQCfHhSEgmhKZg==
X-Received: by 2002:a17:902:c244:b0:1dc:de65:623b with SMTP id 4-20020a170902c24400b001dcde65623bmr9195817plg.60.1713221694056;
        Mon, 15 Apr 2024 15:54:54 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:fbbe:421b:9296:f28c])
        by smtp.gmail.com with ESMTPSA id d15-20020a170902654f00b001e41ffb9de7sm8620808pln.28.2024.04.15.15.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 15:54:53 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:54:51 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Peter Hutterer <peter.hutterer@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	ibm-acpi-devel@lists.sourceforge.net,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nitin Joshi1 <njoshi1@lenovo.com>,
	Vishnu Sankar <vsankar@lenovo.com>
Subject: Re: [PATCH 1/4] Input: Add trackpoint doubletap and system debug
 info keycodes
Message-ID: <Zh2wO0Bnyr8vFSpc@google.com>
References: <f3342c0b-fb31-4323-aede-7fb02192cf44@redhat.com>
 <ZhW3Wbn4YSGFBgfS@google.com>
 <ZhXpZe1Gm5e4xP6r@google.com>
 <92ee5cb2-565e-413c-b968-81393a9211c4@app.fastmail.com>
 <ZhcogDESvZmUPEEf@google.com>
 <91593303-4a6a-49c9-87a0-bb6f72f512a1@app.fastmail.com>
 <Zh2CtKy1NfKfojzS@google.com>
 <484638e2-1565-454b-97f8-4fcc6514a69c@redhat.com>
 <Zh2G85df29tPP6OK@google.com>
 <539776c5-6243-464b-99ae-5b1b1fb40e4b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <539776c5-6243-464b-99ae-5b1b1fb40e4b@app.fastmail.com>

On Mon, Apr 15, 2024 at 04:28:19PM -0400, Mark Pearson wrote:
> Hi
> 
> On Mon, Apr 15, 2024, at 3:58 PM, Dmitry Torokhov wrote:
> > On Mon, Apr 15, 2024 at 09:50:37PM +0200, Hans de Goede wrote:
> >> Hi,
> >> 
> >> On 4/15/24 9:40 PM, Dmitry Torokhov wrote:
> >> > On Wed, Apr 10, 2024 at 10:48:10PM -0400, Mark Pearson wrote:
> >> >>
> >> >> I have a stronger preference to keep the KEY_DOUBLECLICK - that one seems less controversial as a genuine new input event.
> >> > 
> >> > Please see my response to Peter's letter. I think it very much depends
> >> > on how it will be used (associated with the pointer or standalone as it
> >> > is now).
> >> > 
> >> > For standalone application, recalling your statement that on Win you
> >> > have this gesture invoke configuration utility I would argue for
> >> > KEY_CONFIG for it.
> >> 
> >> KEY_CONFIG is already generated by Fn + F# on some ThinkPads to launch
> >> the GNOME/KDE control center/panel and I believe that at least GNOME
> >> comes with a default binding to map KEY_CONFIG to the control-center.
> >
> > Not KEY_CONTROLPANEL?
> >
> > Are there devices that use both Fn+# and the doubleclick? Would it be an
> > acceptable behavior for the users to have them behave the same?
> >
> Catching up with the thread, thanks for all the comments.
> 
> For FN+N (originally KEY_DEBUG_SYS_INFO) the proposal was to now use
> KEY_VENDOR there. My conclusion was that this is targeting vendor
> specific functionality, and that was the closest fit, if a new keycode
> was not preferred.

Fn+N -> KEY_VENDOR mapping sounds good to me.

> 
> For the doubletap (which is a unique input event - not related to the
> pointer) I would like to keep it as a new unique event. 
> 
> I think it's most likely use would be for control panel, but I don't
> think it should be limited to that. I can see it being useful if users
> are able to reconfigure it to launch something different (browser or
> music player maybe?), hence it would be best if it did not conflict
> with an existing keycode function. I also can't confirm it doesn't
> clash on existing or future systems - it's possible.

So here is the problem. Keycodes in linux input are not mere
placeholders for something that will be decided later how it is to be
used, they are supposed to communicate intent and userspace ideally does
not need to have any additional knowledge about where the event is
coming from. A keyboard either internal or external sends KEY_SCREENLOCK
and the system should lock the screen. It should not be aware that one
device was a generic USB external keyboard while another had an internal
sensor that recognized hovering palm making swiping motion to the right
because a vendor decided to make it. Otherwise you have millions of
input devices all generating unique codes and you need userspace to
decide how to interpret data coming from each device individually.

If you truly do not have a defined use case for it you have a couple
options:

- assign it KEY_RESERVED, ensure your driver allows remapping to an
  arbitrary keycode, let user or distro assign desired keycode to it

- assign KEY_PROG1 .. KEY_PROG4 - pretty much the same - leave it in the
  hand of the user to define a shortcut in their DE to make it useful

> 
> FWIW - I wouldn't be surprised with some of the new gaming systems
> we're seeing (Steamdeck, Legion-Go, etc), that a doubletap event on a
> joystick might be useful to have, if the HW supports it?

What would it do exactly? Once we have this answer we can define key or
button code (although I do agree that game controller buttons are
different from "normal" keys because they map to the geometry of the
controller which in turn defines their commonly understood function).

But in any case you would not reuse the same keycode for something that
is supposed to invoke a configuration utility and also to let's say
drop a flash grenade in a game.

Thanks.

-- 
Dmitry

