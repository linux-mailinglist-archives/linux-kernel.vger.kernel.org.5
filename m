Return-Path: <linux-kernel+bounces-9872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4315B81CC9C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73421F2343B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE56E24200;
	Fri, 22 Dec 2023 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqWcLSc9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7FC241E7;
	Fri, 22 Dec 2023 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3cfb1568eso17463215ad.1;
        Fri, 22 Dec 2023 08:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703261703; x=1703866503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wezpUVmeFJK413XLR6tu+q+VD09IwwwiA9OOIXNeVeo=;
        b=fqWcLSc9Au0OYVEyveYQG4bwV9kOrHV039uik7HDUtnuOnrjeqiNDKLQ8NInG7jAnN
         JyKGOnsPhnZpgjW83HrN2ZyooyO8s/HlaJC664SfNk5NZXgZ38qFZLWupl5+7d7tCEfh
         91m0aR15u4z9ZDaTjaRsZ2xvW/dtkNAs3LgXTpHH90nBPlJmfu5lixA5EVUzpaJc4t9v
         rNzJsiMJhwCz9FE46rkMGtA71s5MMjj301TN3VdHEdNH6BnjBXCzikdmUFjfaBzEvTC/
         nrBGlFHB6tfN0umPTDeFvo1/zklWqmwgLtRXi/dbo2TB1rjpYsh8vvsMF+r0SFHDFMcW
         pK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703261703; x=1703866503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wezpUVmeFJK413XLR6tu+q+VD09IwwwiA9OOIXNeVeo=;
        b=RLIrC7ahYbl/0mG4qdbyZgvnGswnkIDI+kCu2HThUnnjFNkipC+cIfeguSwPgTkt6L
         TJ88ljE7ELqgYRsacE3s+cmRUd2j/KNOJw2IJW+1Ez5dLfIee+Gf9j370GCqjCRWRBn9
         H6nYn8zA6sAsttr9oJkOyImwuLxl3j5DcOf6aRrgJ2ncc8Knn2ru474QGOLnDTFnU46+
         4b4OGsVGknwi/4OchTt5fuR5SwTDkCmUevg7EP4pyTMNwSQxHBzy2/bS0UzNxJ7KoRGg
         qC7Zp77EN4VFEKKNnESRDIqCU1jU2K+spDAmFUdcmdiySjJ+tGC2luD+LzyK/ceuLkbt
         LZ2A==
X-Gm-Message-State: AOJu0Yy1419yIkZhh4TCBxZ1+tQzHsnyfqdeSIU0dN+WI7+Wb9OknTVb
	+pgRNkPq8X0/XdA6tFr2DmQ=
X-Google-Smtp-Source: AGHT+IFyiIsL7OsaU9m0+uu4lCHeaAwNpiObSOShUzPf+xU6cRAVKVAX18Z71kcES4oj2kzTH3QixQ==
X-Received: by 2002:a17:903:24c:b0:1d3:f0c1:6ad6 with SMTP id j12-20020a170903024c00b001d3f0c16ad6mr1868085plh.18.1703261703236;
        Fri, 22 Dec 2023 08:15:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d10-20020a170903230a00b001c5b8087fe5sm3629469plh.94.2023.12.22.08.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 08:15:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 22 Dec 2023 08:15:01 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Ivor Wanders <ivor@iwanders.net>
Cc: corbet@lwn.net, hdegoede@redhat.com, jdelvare@suse.com,
	linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, luzmaximilian@gmail.com,
	markgross@kernel.org
Subject: Re: [PATCH 1/2] hwmon: add fan speed monitoring driver for Surface
 devices
Message-ID: <759c5f4b-d3be-4614-a504-c1761554f886@roeck-us.net>
References: <ab8a1ff3-6d01-4331-ba5d-d677d1ad80b5@roeck-us.net>
 <20231221225521.11671-1-ivor@iwanders.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221225521.11671-1-ivor@iwanders.net>

On Thu, Dec 21, 2023 at 05:55:21PM -0500, Ivor Wanders wrote:
> > No, sorry. Limit attributes are supposed to be used to program limits,
> > not to report constant values to userspace
> 
> Thank you for this feedback, I've proposed improvements to the
> documentation in [1] that clarify this. I will incorporate this feedback
> and submit a second version.
> 
This applies to all hwmon sysfs attributes and is already documented.

Guenter

