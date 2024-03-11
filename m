Return-Path: <linux-kernel+bounces-98641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6A6877D20
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7DB1C21087
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB771A27D;
	Mon, 11 Mar 2024 09:43:37 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD8617BA1;
	Mon, 11 Mar 2024 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710150216; cv=none; b=KR7jCYUilwQbGpmbERLTqErcI/KSxp6Y9bJGZ6N6/Aa3IAy4N/I7PE7eaOzsbU8+G0LDhTo2A7l6Pl/2N7SVofpVIetY4HyFx+ETTPHdj6AXUI3BwVu/dFKTbwW6/fC/1A/W0cZT6g6zNfx8ZAIjNcrGhlbd5d26mq66P9jY0zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710150216; c=relaxed/simple;
	bh=Cj1/33qi3GNppvfePk5/WIg6MglQ7s/hn6w2TWXaCa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g99ZcHdrQ1fgGIN4ioKqSw9Sw5HZy08yJA50G3I2UVTkvdJLA0G5GIDWw5itxvzGir6LLkV+bfZklf5h4qDCWE9PgQeS4jXn5Y2ApscNIPcZ4OZSxajoxo0VYR07HN4+f6N6cDIlOQrTuD/hi17kJg0QhmahzA73CsubxbgUe4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so5418596a12.0;
        Mon, 11 Mar 2024 02:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710150213; x=1710755013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=472ntTQJuYHJsEv7z4LlYOPd8nn+YNyDn677YGOjcrw=;
        b=LDaEYMD0xQn2ZkfaaaLF77i4UMP4QqTTrTBGZSivZRaqz9VCLuUF9we5K+mRzNLt2B
         o6ASW+fCGQ37EqlGOAYktQ7rQ2es64iHndTp7tc6EWEPOBeyC9wuZewV8L1v1WFLlkgQ
         WKjbXtZZJSUCGM2ketWTXpTKCGGsYbTSmwbqUGxPJRiKM554yJ8ky3GM4PAEuKsttt5E
         h2ToJemH5St0fqUdK2IYR0uMv1gIrfR3XmQdI5AogYUOyUcYVbThTwx9LA9BEW9KgO+J
         IXR/VaNhtDMrMjNu2v7l/FDNXFUR4rcZPWVusA9X9tEgKyglMOe/KF4AY4NSz7HkRlWc
         ko9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUH0NHQ1rIcDoIqOS7gfMs+euKR8gByHV9gCLz1dGTI47JHHorNlSiFQ5sdZdoyGZZTPxIjHTq+Cf44fniBNFLlwuHoToP371XJk0vXLQPfO5vXmA59NaDEaRN1FSNYSqvuBrD/1rqjCe/9fCRCjYaILzRfikkxgqfUdald08wV
X-Gm-Message-State: AOJu0YzyqV5fAbYZqvN1yQI7mZjpIgJDfJHXVzeCvtNouirIdFLbErXs
	T+uH4eAonw5MJtmIEc5XuSXw+0HQy+AEfydCTSCgQ8XGu8W4kLh3
X-Google-Smtp-Source: AGHT+IFL91Hb14rmPEw8qOSXIsU1i6Gvi/0AB+QZUtjciiVtlXuLkNKojNel443SysQ5aGIG2Z5oPw==
X-Received: by 2002:a17:906:a14c:b0:a3d:4ed8:f5bf with SMTP id bu12-20020a170906a14c00b00a3d4ed8f5bfmr3349896ejb.2.1710150213303;
        Mon, 11 Mar 2024 02:43:33 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906314300b00a4558314ea0sm2739025eje.15.2024.03.11.02.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 02:43:33 -0700 (PDT)
Date: Mon, 11 Mar 2024 02:43:30 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Matthew Wood <thepacketgeek@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: netconsole: Add continuation line
 prefix to userdata messages
Message-ID: <Ze7SQlSOxLd+cOPA@gmail.com>
References: <20240308002525.248672-1-thepacketgeek@gmail.com>
 <20240308201728.59e2e0ff@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308201728.59e2e0ff@kernel.org>

On Fri, Mar 08, 2024 at 08:17:28PM -0800, Jakub Kicinski wrote:
> On Thu,  7 Mar 2024 16:25:24 -0800 Matthew Wood wrote:
> > Fixes: df03f830d099 ("net: netconsole: cache userdata formatted string in netconsole_target")
> > Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
> 
> Breno, LG?

Yes, I've just added my "Reviwed-by"

