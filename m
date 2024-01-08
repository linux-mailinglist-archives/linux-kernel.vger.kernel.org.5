Return-Path: <linux-kernel+bounces-19683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAF68270D3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C0D1F22DF9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6370346445;
	Mon,  8 Jan 2024 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwroT/EZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595D846443
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704723352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YxB4hJGUskiSNKv+s1TrmZMXKolMvHe6Ob3/kfn7C0U=;
	b=GwroT/EZ1rSg5urEdfzD9J3XHHI0RPmz7zGQqlx6ODX7GWe9aeKlvzIrPm8OVxUoyqk3w0
	6xcsoHsEbFN3r3EV9+oqvKKnvi3+gn0AJ3xg3HkOad8md0kha+kLV+8XgApNmnp6YArVuh
	kTd64wnl44JkfqTD/wIwiy7c7TH5VLI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-cItuvT5kNk-x4aX6rpG3XQ-1; Mon, 08 Jan 2024 09:15:48 -0500
X-MC-Unique: cItuvT5kNk-x4aX6rpG3XQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3374e909bf0so1325090f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 06:15:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704723345; x=1705328145;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YxB4hJGUskiSNKv+s1TrmZMXKolMvHe6Ob3/kfn7C0U=;
        b=mkVbdD5Be8WWHOta6TcyYksKCPeDHfyo7dXcMy5IuJ7RnjLMiQSz72FA7KFdQvO1kZ
         dBZIGbKT2b1vFAWmzXuXwRrSrWktNxApD1EAuJKG64nRebFZdRMYnFTV5wecczvvMWyK
         v7DEg9xRMkWBCqmNwgd3U8aIgcOB0eY8qax3k5OzOy2/RFYq2sYF1cn4iwsdFSIuURS0
         oJymVnPlTey+gWjlm9cxKTL5XUwFlSoE9rIxzvs+G6PjrJHCJEtRuC7ik928TWCjYcQq
         F31LFNdx0G0rINjIeQ4i2wfFveHeTLEOa71kSXeju1xtOA0gNB2B8IvNlOAm8rHB+++j
         T1IA==
X-Gm-Message-State: AOJu0Yz9BJh8AjQPHFGfdCJkiUGMhfSUBAxkZCr5akAcVYrPOtbNKPKu
	F9e3KJ0MzDyR53tD7QoM9LZKjPCwE+GiK53d543jSMk3GD78h+LeehShe87xRryzYF/yjel18iq
	77D65Wqlf/64qEMt9Mf+MlhsLYcq68RTwph+7EV1G
X-Received: by 2002:a1c:4b10:0:b0:40e:48b5:3349 with SMTP id y16-20020a1c4b10000000b0040e48b53349mr432191wma.25.1704723345541;
        Mon, 08 Jan 2024 06:15:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6B2nGNQDVdFDm3USpj0QhZ27T8ggPZi0nN4hlsNXsc4GJ1RmAnYI10aMq5+7l7vGing5psw==
X-Received: by 2002:a1c:4b10:0:b0:40e:48b5:3349 with SMTP id y16-20020a1c4b10000000b0040e48b53349mr432170wma.25.1704723344860;
        Mon, 08 Jan 2024 06:15:44 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b0040d5c58c41dsm11210711wmo.24.2024.01.08.06.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:15:44 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>,
 linux-serial@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-input@vger.kernel.org, Lukas Bulwahn
 <lukas.bulwahn@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] vt: remove superfluous CONFIG_HW_CONSOLE
In-Reply-To: <20240108134102.601-1-lukas.bulwahn@gmail.com>
References: <20240108134102.601-1-lukas.bulwahn@gmail.com>
Date: Mon, 08 Jan 2024 15:15:43 +0100
Message-ID: <87y1czdi7k.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

Hello Lukas,

> The config HW_CONSOLE is always identical to the config VT and is not
> visible in the kernel's build menuconfig. So, CONFIG_HW_CONSOLE is
> redundant.
>
> Replace all references to CONFIG_HW_CONSOLE with CONFIG_VT and remove
> CONFIG_HW_CONSOLE.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---

Makes sense to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


