Return-Path: <linux-kernel+bounces-163442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1FA8B6AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70F061C216C2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EE92556F;
	Tue, 30 Apr 2024 06:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Mz1aQHJx"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB57199AD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714460227; cv=none; b=hkLA9gAjDdV/mxGBoKFewKoLcNHHA8IUHXMKmHtXz29FCp5ClojRZnrlFezqH/NLkIUTYjyNGdOK6ynnTzmecxTHK6GS2+LCsFl8P2N57l5lF7zj9Bf3TO81clImwNkw/paPNt4s0ppagosodSUoqVmVnQUaa8ThGn0K5Fzo1KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714460227; c=relaxed/simple;
	bh=RIER2WvaRzlpoin4ttKrbUvzJsxNJZ81t+tcedDHBns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qf7sKMOUYoc6T9ryYKLokZkoJe+f2XReb6sZ1mXQZT62sWQGa+5VENTBEUmk1gZ1yoLWWEEIAsxDeaFKjZxz6wIir5MkscQcPcNwYejn+RQqteFSG14P4wa6yhKMFo7OmSVSlTn/RJK9Ot8ItzyFxX7NmfHwhFtbKHaXljF+hF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Mz1aQHJx; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a52223e004dso566808266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 23:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1714460224; x=1715065024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4FVgR1Dca7XJuk7IfME3aBiJ0pOrXTj6aIOqyadopmE=;
        b=Mz1aQHJxbZalGnPb2m7UDQ7NBpeu71j4NiKjcze8vZ/i8TIjRyqw+jAJECRkhJCcAu
         HIqHytcb4/t4Njtjnz0R5bXcgUIAO0TJv2lJ1XFxrxRlxBMHgk9BTssuMZeONKlkQGzp
         bSs15ijyOzgvoFBfGnUOHQjYIr9aPeP9gAjiWhGCoUwMfueObTfpMjLeshJoGbNld7f8
         ecWD71VHtz5WzX8kXqYZnME9pzyS4WGGqcCjpxS1jhP3p/I9IX5q+JoP24NaKa9WrhDU
         9WoqcQ/TetwN4SmrTq1reMRAtTXpqOAzU8u/rLUG8rF7w8MFl0HGFaPnkoEpxxb9226g
         mTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714460224; x=1715065024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FVgR1Dca7XJuk7IfME3aBiJ0pOrXTj6aIOqyadopmE=;
        b=YD7fjmXB+BacnRIjym7jSR8QqOqGVvX8GzPk+QjkZTfY5PlEE8LJmoY6GVgdZQJsrF
         NskbhKI/AM8eXezqJPa3lm299xTWGQR3NIg2KYn3qDgJnWQnf2bgalkINv6cC5doygQj
         dHBJ1GQTVCYcrXdUng8cR6/+GZ0zjno32oHqtCWKZfAdn5Cuq7B7oB9Jpw6vK5OsNLDY
         ODXurr9oZJzhXd+2wxk69+TjC+AtV+jkKnYWde1UIKx9fQqtt2ugV/rCcm2x5YxxCYP3
         mwruyIk8s25IxKwLH/VL1BlOxBjGpn0HuPiOMMpsGpyRcxgm7ZVHfXq0AACUCRd3Wz2x
         9SOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFyxKvPS1vSio+ly8VTp9EvsArhezVWDxzjtYqhn6PFN8Z28hsBGs8a6ntANS23rm3G4GgxY1mciiRO+0zNuYEgu7/XVPwpKxiGCMV
X-Gm-Message-State: AOJu0Yx/xbLYBRLLSMF/lGpl/rF5g/z0UqVXrEwRzoe3EJY4RgtuPh2p
	TkMREsoQkeKZtUP/Pf1+APgVNjuZlJhad0kry28Gvqjeywm+zTmPG8vaYDbYoqw=
X-Google-Smtp-Source: AGHT+IFrFHeHXzh/hc5I4ZUwY8RPWgtyTjn4NhRcMXWKKg8DwzJaQW+uzv7T/QzmolLZYjZ+a/rPaw==
X-Received: by 2002:a17:906:3597:b0:a52:6a33:2ea4 with SMTP id o23-20020a170906359700b00a526a332ea4mr10321515ejb.54.1714460223757;
        Mon, 29 Apr 2024 23:57:03 -0700 (PDT)
Received: from localhost (37-48-12-67.nat.epc.tmcz.cz. [37.48.12.67])
        by smtp.gmail.com with ESMTPSA id o20-20020a1709064f9400b00a51e9b299b9sm14689394eju.55.2024.04.29.23.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 23:57:02 -0700 (PDT)
Date: Tue, 30 Apr 2024 08:57:00 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geethasowjanya Akula <gakula@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [EXTERNAL] Re: [net-next PATCH v3 3/9] octeontx2-pf: Create
 representor netdev
Message-ID: <ZjCWPEony0Q22AEt@nanopsycho>
References: <20240428105312.9731-1-gakula@marvell.com>
 <20240428105312.9731-4-gakula@marvell.com>
 <Zi-Fg7oZBCtCvbBA@nanopsycho>
 <CH0PR18MB4339BF5712F2E93835E1EA08CD1B2@CH0PR18MB4339.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR18MB4339BF5712F2E93835E1EA08CD1B2@CH0PR18MB4339.namprd18.prod.outlook.com>

Mon, Apr 29, 2024 at 06:13:56PM CEST, gakula@marvell.com wrote:
>
>
>> -----Original Message-----
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Monday, April 29, 2024 5:03 PM
>> To: Geethasowjanya Akula <gakula@marvell.com>
>> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org;
>> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
>> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
>> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
>> Subject: [EXTERNAL] Re: [net-next PATCH v3 3/9] octeontx2-pf: Create
>> representor netdev
>> 
>> Prioritize security for external emails: Confirm sender and content safety
>> before clicking links or opening attachments
>> 
>> ----------------------------------------------------------------------
>> Sun, Apr 28, 2024 at 12:53:06PM CEST, gakula@marvell.com wrote:
>> >Adds initial devlink support to set/get the switchdev mode.
>> >Representor netdevs are created for each rvu devices when the switch
>> >mode is set to 'switchdev'. These netdevs are be used to control and
>> >configure VFs.
>> >
>> >Signed-off-by: Geetha sowjanya <gakula@marvell.com>
>> 
>> 
>> Are you still missing creating of devlink port as I requested? Why?
>Sorry I missed your comment on earlier patchset.
>Wrt adding devlink port support, our plan is to get the initial patchset reviewed and then add 'devlink port' support.

You need to do it in this patchset. Rep netdev without devlink port is
unacceptable from my perspective. Thanks!


>Will submit 'devlink port' support as a follow-up patch series.

