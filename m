Return-Path: <linux-kernel+bounces-675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFA381444E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17531F234EC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54637179A2;
	Fri, 15 Dec 2023 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALAGWiEz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416F0171C8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702631618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mCTQScLuKQiezRjjUFhdXG9Jlauh3ct64es9RA+0UfM=;
	b=ALAGWiEz9km3hoa/FyLtYTrgIlOX37D1SYQsLThEJgmkrY+UwCN4Ih+Cj3fA/SvwG7eo6y
	MPv5LSQcfTq8/kZhSlPFnCCPhaTucUEHHs6Kmrq5zoFJMqYSWX6mofjuelZ3pL+bdeJcCs
	kx3nKHitUyMmoEXSngzaFp8Oz1BoKYI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-7LB8ydbMN0eU27vvmvYFcw-1; Fri, 15 Dec 2023 04:13:34 -0500
X-MC-Unique: 7LB8ydbMN0eU27vvmvYFcw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1cc20d32dfso27797266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 01:13:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702631613; x=1703236413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCTQScLuKQiezRjjUFhdXG9Jlauh3ct64es9RA+0UfM=;
        b=ZmxyFnX1F25X9za0BS8KXTGyBX5bi3xyawdwPArWACNAaTs3ntQBGCxd1GwgBbeeVk
         230bBxMw34bUIxpzK3M40Bry46A8qqnTJZSjHwjvn8VNFiuvB1vY2HoOTh4LLmKpJhAC
         JXhM9xmeud5zB5Tanffpcz9oDbIGkr07kkmoZkphXQFgUNBjO5ZF42BRmLGc1YIpn8tD
         daFmmNJB8edwtAU1/PaYm7w4gtVVaC/WRYinCo/yyvbpnVvc3XD//93J1Q9Yn4n+S11p
         cy3/JwP5ABCX5oFzFU88urnm0XbpyLCesDsJDgqMimniprVseze+vA2VxH0KSj6BAQ9u
         +WRA==
X-Gm-Message-State: AOJu0YwXPpvyc69ob8HoVBqNWDJ4c5+HKGwHwKrDdJWbpVHmbK7qIY9S
	qMSwvbOBB9YmTe8aoD6M8seQ4T7LLGMza8kpvWwYbF+9uvlKxm4Wwt+rRAvlBE7O3hWPeJUOShC
	Uo49Sh9b9iRiaDEJbXg6NrEtE
X-Received: by 2002:a17:907:7ea1:b0:a1e:9d8b:1e7b with SMTP id qb33-20020a1709077ea100b00a1e9d8b1e7bmr6763942ejc.69.1702631613258;
        Fri, 15 Dec 2023 01:13:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQX2K49wZx8NRs4i3izG9jXcEjfCvo6Nhck0rRshHPWrt45MA2CA1J4VUIPKs3qJYCJq+Npw==
X-Received: by 2002:a17:907:7ea1:b0:a1e:9d8b:1e7b with SMTP id qb33-20020a1709077ea100b00a1e9d8b1e7bmr6763936ejc.69.1702631612926;
        Fri, 15 Dec 2023 01:13:32 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id un7-20020a170907cb8700b009fc42f37970sm10618107ejc.171.2023.12.15.01.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 01:13:32 -0800 (PST)
Date: Fri, 15 Dec 2023 10:13:31 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Fiona Ebner
 <f.ebner@proxmox.com>, Dongli Zhang <dongli.zhang@oracle.com>, Jonathan
 Woithe <jwoithe@just42.net>, "Rafael J . Wysocki" <rafael@kernel.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Bjorn Helgaas
 <bhelgaas@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "PCI: acpiphp: Reassign resources on bridge if
 necessary"
Message-ID: <20231215101331.3db4d131@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231214165102.1093961-1-helgaas@kernel.org>
References: <20231214165102.1093961-1-helgaas@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 10:51:02 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> This reverts commit 40613da52b13fb21c5566f10b287e0ca8c12c4e9 and the
> subsequent fix to it:
> 
>   cc22522fd55e ("PCI: acpiphp: Use pci_assign_unassigned_bridge_resources() only for non-root bus")
> 
> 40613da52b13 fixed a problem where hot-adding a device with large BARs
> failed if the bridge windows programmed by firmware were not large enough.
> 
> cc22522fd55e ("PCI: acpiphp: Use pci_assign_unassigned_bridge_resources()
> only for non-root bus") fixed a problem with 40613da52b13: an ACPI hot-add
> of a device on a PCI root bus (common in the virt world) or firmware
> sending ACPI Bus Check to non-existent Root Ports (e.g., on Dell Inspiron
> 7352/0W6WV0) caused a NULL pointer dereference and suspend/resume hangs.
> 
> Unfortunately the combination of 40613da52b13 and cc22522fd55e caused other
> problems:
> 
>   - Fiona reported that hot-add of SCSI disks in QEMU virtual machine fails
>     sometimes.
> 
>   - Dongli reported a similar problem with hot-add of SCSI disks.
> 
>   - Jonathan reported a console freeze during boot on bare metal due to an
>     error in radeon GPU initialization.
> 
> Revert both patches to avoid adding these problems.  This means we will
> again see the problems with hot-adding devices with large BARs and the NULL
> pointer dereferences and suspend/resume issues that 40613da52b13 and
> cc22522fd55e were intended to fix.
> 
> Fixes: 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
> Fixes: cc22522fd55e ("PCI: acpiphp: Use pci_assign_unassigned_bridge_resources() only for non-root bus")
> Reported-by: Fiona Ebner <f.ebner@proxmox.com>
> Closes: https://lore.kernel.org/r/9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com
> Reported-by: Dongli Zhang <dongli.zhang@oracle.com>
> Closes: https://lore.kernel.org/r/3c4a446a-b167-11b8-f36f-d3c1b49b42e9@oracle.com
> Reported-by: Jonathan Woithe <jwoithe@just42.net>
> Closes: https://lore.kernel.org/r/ZXpaNCLiDM+Kv38H@marvin.atrad.com.au
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: <stable@vger.kernel.org>
> Cc: Igor Mammedov <imammedo@redhat.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 601129772b2d..5b1f271c6034 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -512,15 +512,12 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
>  				if (pass && dev->subordinate) {
>  					check_hotplug_bridge(slot, dev);
>  					pcibios_resource_survey_bus(dev->subordinate);
> -					if (pci_is_root_bus(bus))
> -						__pci_bus_size_bridges(dev->subordinate, &add_list);
> +					__pci_bus_size_bridges(dev->subordinate,
> +							       &add_list);
>  				}
>  			}
>  		}
> -		if (pci_is_root_bus(bus))
> -			__pci_bus_assign_resources(bus, &add_list, NULL);
> -		else
> -			pci_assign_unassigned_bridge_resources(bus->self);
> +		__pci_bus_assign_resources(bus, &add_list, NULL);
>  	}
>  
>  	acpiphp_sanitize_bus(bus);


