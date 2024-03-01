Return-Path: <linux-kernel+bounces-88399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBD286E113
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6941C2094B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EADDEDB;
	Fri,  1 Mar 2024 12:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9+IIolr"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7768386;
	Fri,  1 Mar 2024 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709296275; cv=none; b=Ud7jB2atGXp9WlE3QG8FWgYyIN3Rbsj9sxzNcWQ1gl+GXMcUch1c4pI8hNrNuoQPeNnpbpl2kmjevH93zSkdDPgW2MLQTkm4/cCr8L0NZyIy59OVEsiicfUHByg1RiteqemjNwqYd8PMO6HhontAmgsgjqMBY8yUHrJpT+fmNpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709296275; c=relaxed/simple;
	bh=8RnPvClv7KQ+Hc7khmpr12985u/duy/3v/TKfh9A88M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M7bl3P6q36aolLpPvgUoJbp3sr32b7aa7AtRWtFJhhE9/WzqsB2oNZBY1lYYPODuQ+7nV1rteeaweuBJAb+gAuPXhkd9cFra2I4E2fCUwV/0nOvsG02weewWlQO4FZOIgUWn0XIbP5peEVIdc3yMiF38IXR3q47lqEdzhqiar9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9+IIolr; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a44ad785a44so33663866b.3;
        Fri, 01 Mar 2024 04:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709296272; x=1709901072; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qOvH3P5HGSrpjjPMuyCiz1PZ+rc7XO0ytGp7zjRcMjA=;
        b=D9+IIolrOZn1OMYjdvDPv+KaOQ3NJN8dZmRvhfSp5S8bL3aUlmzGIiI5Uf9HrAAWNJ
         voF2UvLvHtLLecuig44i1zJoh2iJzbCpKpJqDO+CNWZb93XG1GUk5+kicw0VkB5/LbMO
         fvexk1/KtHD8Qh8W7tflzvA58qWX29rZfDNmt+gi9FpBHmJUphGByxNrzxVVthbfU3fm
         t3KqafE2GN8W1ZLFwf0NcryB+Bf8dXeLGdBB1e57jlUpLOTanaO9vDQ2hgous4E3gjmb
         5Vem/4suECsS91Ay51fqiOxqwX3WMSVFV85qMWHog8Z0JwzA352YrroIZz4HDRc+fiUw
         uepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709296272; x=1709901072;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOvH3P5HGSrpjjPMuyCiz1PZ+rc7XO0ytGp7zjRcMjA=;
        b=USIx4UpJlBDxyWA/XSPv1G6Lg+ur56Qky4LObvdIhMHpeNnIiKkbDf7GjMii1J/K6r
         aEppudlIyeUl9Pc9IVPvzRpoldWkpLz4YHmbYr0N9nmK0yoC2DsPEZWcn4cMYxDSGGh+
         BeEV7vybqqeiAxWiWZS3cSH23LvMkEsC4/sjtR/SGzIy9HxkUnpvLyrlw8QIr79wbXk5
         f7BOL7R0zI+2yD/PlO70eoaW2MHeoTn9SIMsWCM2BLPbAirStv673L6kS7PM9uUGya6a
         etMrt94IUZVsjcshwNe+TFUzbsRe9AZXAkjTk+jK07ismN4QzJ56+JS6SivqogOVr1dy
         7STg==
X-Forwarded-Encrypted: i=1; AJvYcCW7weBHJLLEjTB1IwxjYEoWAUCWXJxfh88kj+WNpnGGr6cUJ5S/tK++g9krv1vin4mPjuKFsuhCRESFJ1SERFwC+/1xLtDwF8iRb8rSE2UhwAo12bqOA/pCd+ACWDoiu4LYhNhzaIArG8q1DKVnby0ier7l+oGDyxho4zAmRVOh
X-Gm-Message-State: AOJu0Ywd/09w2y40AbIhcbuNAQZCkuvHGVRWtgExtGaMqUVBhWrVPjn7
	Gf3i5Q+miJp3ANrv1FNAfw1jL2RkvB9eNc2V4QeXIIC38fOTghDzV2ExrilxzZA=
X-Google-Smtp-Source: AGHT+IFd140UexM9EOnEMJHomFWLoVYeGO7aw8HyZ/c5klK42r+DtIXPre1WNqulSOjeGkGfj4x07w==
X-Received: by 2002:a17:906:ccc8:b0:a44:1a51:a1fd with SMTP id ot8-20020a170906ccc800b00a441a51a1fdmr1069869ejb.64.1709296272204;
        Fri, 01 Mar 2024 04:31:12 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id mp7-20020a1709071b0700b00a440ceb4110sm1673266ejc.183.2024.03.01.04.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 04:31:11 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id D1E30BE2EE8; Fri,  1 Mar 2024 13:31:10 +0100 (CET)
Date: Fri, 1 Mar 2024 13:31:10 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: regressions@lists.linux.dev, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Aditya Srivastava <yashsri421@gmail.com>, 1064035@bugs.debian.org
Subject: [regression 5.10.y] linux-doc builds: Global symbol "$args" requires
 explicit package name (did you forget to declare "my $args"?) at
 ./scripts/kernel-doc line 1236.
Message-ID: <ZeHKjjPGoyv_b2Tg@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Ben Hutchings reported in https://bugs.debian.org/1064035 a problem
with the kernel-doc builds once 3080ea5553cc ("stddef: Introduce
DECLARE_FLEX_ARRAY() helper") got applied in 5.10.210 (as
prerequisite of another fix in 5.10.y):

> The backport of commit 3080ea5553cc "stddef: Introduce
> DECLARE_FLEX_ARRAY() helper" modified scripts/kernel-doc and
> introduced a syntax error:
> 
> Global symbol "$args" requires explicit package name (did you forget to declare "my $args"?) at ./scripts/kernel-doc line 1236.
> Global symbol "$args" requires explicit package name (did you forget to declare "my $args"?) at ./scripts/kernel-doc line 1236.
> Execution of ./scripts/kernel-doc aborted due to compilation errors.
> 
> This doesn't stop the documentation build process, but causes the
> documentation that should be extracted by kernel-doc to be missing
> from linux-doc-5.10.
> 
> We should be able to fix this by eithering backport commit
> e86bdb24375a "scripts: kernel-doc: reduce repeated regex expressions
> into variables" or replacing /$args/ with /([^,)]+)/.
> 
> Ben.

What would be prefered here from stable maintainers point of view?
AFAICS e86bdb24375a ("scripts: kernel-doc: reduce repeated regex
expressions into variables") won't apply cleanly and needs some
refactoring. The alternative pointed out by Ben would be to replace
the /$args/ with  /([^,)]+)/.

# 5.10.y specific regression
#regzbot introduced: 443b16ee3d9ce0a3ece0e3526a5af883e5b16eaf
#regzbot link: https://bugs.debian.org/1064035

Regards,
Salvatore

