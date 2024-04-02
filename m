Return-Path: <linux-kernel+bounces-127931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C03F8952E0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CD4F1C21CC2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D74D78685;
	Tue,  2 Apr 2024 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXRs1/Pd"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F5077623;
	Tue,  2 Apr 2024 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060630; cv=none; b=Sl8lH0d5U8lnj58jPts5lJYejhh8R0XuvhpM91hrmL5eLQlKhdEC5aBUAwcXHEO+aRHC/DLpfZIaehjPrrKOLw7jm/3Z1nfTkd2BNp7URch4m6NDj2hdnakItjsPshv0iilOaykamayzicVoT4GRZtufz1Q36PhXMx63qkK9l/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060630; c=relaxed/simple;
	bh=4QZLZAns8p7vUq4xXyL7Kp528hkrlWGkPY4oiD0R4zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNjUywvj48vF6ef7MJx/De4Nxo7BZlOjuKlWPReGwTOpdCeci49Jf+OnGnS25NhTr03LrnEwY0lKx1OsmYWw6M+WHj+EaCnkDoV8fPrNmiv95adjjsAPYuw6+9WdfwEGL0EXwpfvEFf3Lusz7QgnjeBzIWa6XAVoeg9CERfhpac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXRs1/Pd; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso4975677a12.3;
        Tue, 02 Apr 2024 05:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712060627; x=1712665427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/unssVqP/tBj5M6lSsNX5+k+FjirzQl74biGWZLi7vY=;
        b=JXRs1/PdC/LrklKqT+2oKK5gqLIrkWcUefEX2WzfF1zv6wxSvulPiN5B6fxTgc1JD+
         SMOcbNnaRf3k+2LEb3D460f10LDW627pBIDY3xPSCLuvq+awg/LpW1eKbBYtLYhEJhna
         H6NAXS5eikTFV/Ik53bNzKZn4xO5Zh/frIwON4aKGolB/KKfKR7XNgaMg8+Wv/BRtrIS
         S6J63rw9RKmoNuhboLEMfZ6tODwQuaw+nkpECrD4SF7gtR9483KMWzbgzY7/n3uzrvlh
         u1nVmmeghpdTpFIpFa2ZnPj7RVb8QgSbILvI+MawyelilRQX6wyJv6MXvbg3sDRIl9wy
         SGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712060627; x=1712665427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/unssVqP/tBj5M6lSsNX5+k+FjirzQl74biGWZLi7vY=;
        b=lLaX0qZ5JrBHnOeoNERG9FRWAb5T4bmHyRTZ6oEacJT9nQzdaFDqvY1K2z6qA9XrqK
         kw1ilVpDRHXTDZl91gYfCE7nwQeT2fRAhJdVnqWuaF8H6jlPW+8wAKCyPLIWk1NxkhGf
         1J+1rOdA9Mowiyw8DD1VfhWtMrT5YeC8nLA6znk7iOa17gfQla7HM593msj0c88V5KLt
         GJDhh41Kk665AxySSIcCTfqxUMQJSKXuc8h6lJw/M253qlcEETP5y1UiVYUw9qhtnPJZ
         DFg4SoV0GxDGqiWBNr3I5I3agRIx/wEtRSDqTPE8tezEf7DZulrvpYRaUDiyqmfuVI7b
         NsMw==
X-Forwarded-Encrypted: i=1; AJvYcCWx38W3cfdObRIH8kmITIqHb7NMgkFr8g7NS5MRxvKbEJvWf4oS5+pt48bA9bsugwqh8aIgqSDHgbse+7H/vIlQ728TQhmN2U94E/B+
X-Gm-Message-State: AOJu0Yw7L0B2M+DO9sktBpcBhv31X+XdJ1zmvMQSyjkge8++1PIXdFk5
	PmfTpNLXpXuTiJQ+w9OiT4V6t6N95CM9jZ8r5EikcXoMQA5Rcdbq
X-Google-Smtp-Source: AGHT+IEamF/yD6pmqhtSfavUbe4xrWX+kXF6DzNjAP+lKX91t5p2IpXkzvujMeoIPm+Pgq1cmq9sqg==
X-Received: by 2002:a17:906:52d1:b0:a44:51c1:733c with SMTP id w17-20020a17090652d100b00a4451c1733cmr9691934ejn.39.1712060626861;
        Tue, 02 Apr 2024 05:23:46 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id wr1-20020a170907700100b00a473a0f3384sm6516024ejb.16.2024.04.02.05.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:23:46 -0700 (PDT)
Date: Tue, 2 Apr 2024 15:23:43 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH RFC net-next 07/10] net: dsa: mv88e6xxx: Track bridge mdb
 objects
Message-ID: <20240402122343.a7o5narxsctrkaoo@skbuf>
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <20240402001137.2980589-8-Joseph.Huang@garmin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402001137.2980589-8-Joseph.Huang@garmin.com>

On Mon, Apr 01, 2024 at 08:11:06PM -0400, Joseph Huang wrote:
> Keep track of bridge mdb objects in the driver.
> 
> Similar to the previous patch, since the driver doesn't get explicit
> notifications about mdb group creation or destruction, just create
> the mdb group when the first port joins the group via
> mv88e6xxx_port_mdb_add(), and destroys the group when the last port left
> the group via mv88e6xxx_port_mdb_del().
> 
> Use the group's L2 address together with the VLAN ID as the key to the list.
> Port membership is again stored in a bitmask.
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---

Can you comment on the feasibility/infeasibility of Tobias' proposal of:
"The bridge could just provide some MDB iterator to save us from having
to cache all the configured groups."?
https://lore.kernel.org/netdev/87sg31n04a.fsf@waldekranz.com/

What is done here will have to be scaled to many drivers - potentially
all existing DSA ones, as far as I'm aware.

