Return-Path: <linux-kernel+bounces-58530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 761EC84E7A7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1A5282E1C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC1286133;
	Thu,  8 Feb 2024 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkQPX2Bz"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D0282D6E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 18:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707416866; cv=none; b=YbIjVyh7eTQYQUqmRWaKc3Jis/bocB5cGnbsK2INRRTgcTkw+cp0DxW1pX1f7eLyEX0Y7uolNNI3TGW/8stdG06NXlm9ppRDZuD2//QR/lfFd2BvkNeGblkf52RJAz2GPaVTk/UGUoGvBEz0eY0/xXA/poIyK42rfscgluzSl8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707416866; c=relaxed/simple;
	bh=NzJGgM4NwbqWmAsXyU//0SB2LkZUmuH8In9cIyvHRLI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=te0xuI07bLR5gwCNyg+4hcPjMTCQ7RMPhoNOzWFvEDZVt4ALMrxZcIcZgRMOa6n7gPjH1uWrDqaQTIwyAkx0vdSux6txTnuKowrYuNSPvySt7ZHd6HUEhYF2tR7PJsslBacH8BI/94b82Co0eb7nRR7LgblckkV/B7mTULFvGtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkQPX2Bz; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51174101765so105502e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 10:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707416863; x=1708021663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MhiQCIizSoOoGlOJh1aEc+Kedwwy9bu+6Ox2q8gZmik=;
        b=HkQPX2Bzxe7UgEnGgGeGqyIRkdi6e/uU8JmHFNfjJrLUPVEljlPZi9GIfR8Je+2oSl
         3DBT5oPuLTtShh2pdrFv5F866QfWa7G0s2llPjLW30gDYulTPF4Qp3Vewa+3BX+iWN3k
         I9BQ57CSqtJpJ7MmafTfS03l4THPbeCu/NM005A9vfhuU2TTnyqHQPQqIyMocA1lvO7m
         rW9Eu/qDJJLotBr7JojBvjlEjQEDMNbCfKiJVCZbgu/6uO/ME5UfNl+ckyPaPBl0RUw8
         4FP93XODum1e3RlwLFIiilPQXJvzKl4ScAMpUoDzvppaR0NaLyU7r/s5s5CC2OPKKHEN
         W1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707416863; x=1708021663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhiQCIizSoOoGlOJh1aEc+Kedwwy9bu+6Ox2q8gZmik=;
        b=oTckJugaXOXlMoMYY5szX8Objgnqf8O7NJcMtwPNeuQY/2nrj+AWxvn4i8A9V2ooad
         nQFMGYZeFyv1s5DbLh/WpgZR4XZQTjfuGC6i0xJZ7+G2UPFeK9fU6qW4C49yQpxm34d0
         4s2GzC9l5HmHZHULzULiW/xSAkkwXfK7wzGg6dQnyL879sJM3EnH/tvRbt+pLZPOHURJ
         6+vrAnB6deD4QsYEJNn0t/lVW9b072erRhc6xFfh/7ck8olRxMW5x0J0qZncr/lGWWUt
         c7YUiNaPt3LoDffnI+jYz4bn43AOGIElwyzP+v8XzvZ4fn2HQUcjZ2e8UNlWC2BBlqiD
         O8Ow==
X-Gm-Message-State: AOJu0Yy4/76qU6IsLrLOJgpwb2Zll7xJP6Sem9A/fkSQIm055tMWUaow
	6aieP2u+J0X1ZOdZSyAgV0YsQzFaU5ipu0ubLI6JSY2pgMBqV8MB
X-Google-Smtp-Source: AGHT+IEt1TA9WaZV161QOsVJTKIO45dwFrmr5lsjYI1a2PuuFU/uotVfRvKIQ12At8iMiW8KxfJUKw==
X-Received: by 2002:a05:6512:3ca3:b0:511:4fb4:94f4 with SMTP id h35-20020a0565123ca300b005114fb494f4mr46153lfv.53.1707416862702;
        Thu, 08 Feb 2024 10:27:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW73WLa6OSXt77bWdX/B/C6TGTeT1GCQPBjP9edjIgotYXUWF9+OyugsyGpxeAbsI1Qa7ibGuUaCMI1fgW7xbP2ZnhjXPqLApJwox89/312sbZI/9/NLizNPLJwj3ZJ7qTQfHZ3C/DvcYaVhsiZMSxEjwxHi6Vg3W7SNpMbGaOA4BbkPgSj2CSNDUi6fNWjYsOlNmTrmaStBrrLUBSKT6N3q6TJCXS6YrrazEBXzSXx46MjBkTdWPROUHw3RtSULg3F+BxX5hZKA7YLjAU8DoXj6jIh3vRvFW16i58N5fObGPpcrnuAu8xn8q+GSdLPfHQ9/JSm/x2PTLlMT5cjoDSZapNi+42P1EqwdgQBKeZUgUm2+6fIn3etemm1PgnaxJZN1pmnyr8TKZ/MR6X5B3m3Vst3IbIwODfIpuqdQsT62z9Ia/jNPnaRFfQTYATfWWVkfKzRSxw1jwYmPYKAzOzXVGBeFwmKmaL4tekmgheOOsROPWrQKW0e
Received: from pc636 (host-90-233-221-0.mobileonline.telia.com. [90.233.221.0])
        by smtp.gmail.com with ESMTPSA id w6-20020a05651204c600b0051151e07c01sm28780lfq.36.2024.02.08.10.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 10:27:42 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 8 Feb 2024 19:27:39 +0100
To: Andrew Morton <akpm@linux-foundation.org>,
	Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	casper.li@mediatek.com, chinwen.chang@mediatek.com,
	qun-wei.lin@mediatek.com, linux-mm@kvack.org, urezki@gmail.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] scripts/gdb/vmalloc: fix vmallocinfo error
Message-ID: <ZcUdG5snmTW1ldx3@pc636>
References: <20240207085856.11190-1-Kuan-Ying.Lee@mediatek.com>
 <20240207155623.a943328ba0b77859246e0d9f@linux-foundation.org>
 <20240207155929.cc107bcc14b982789bdc9fab@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207155929.cc107bcc14b982789bdc9fab@linux-foundation.org>

On Wed, Feb 07, 2024 at 03:59:29PM -0800, Andrew Morton wrote:
> On Wed, 7 Feb 2024 15:56:23 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > > [1] https://lore.kernel.org/linux-mm/20240102184633.748113-1-urezki@gmail.com/
> > 
> > vmap_area_list was removed by https://lkml.kernel.org/r/20240102184633.748113-6-urezki@gmail.com
> > 
> > So I think this patch is actually a fix against mm.git:mm-unstable's
> > mm-vmalloc-remove-vmap_area_list.patch?
> > 
> > However this gdb function was probably probably broken earlier in that
> > series, so perhaps this patch would be best staged as a predecessor to
> > Ulad's vmalloc series.
> 
> ie, this:
> 
> 
> From: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> Subject: scripts/gdb/vmalloc: fix vmallocinfo error
> Date: Wed, 7 Feb 2024 16:58:51 +0800
> 
> The patch series "Mitigate a vmap lock contention" removes vmap_area_list,
> which will break the gdb vmallocinfo command:
> 
> (gdb) lx-vmallocinfo
> Python Exception <class 'gdb.error'>: No symbol "vmap_area_list" in current context.
> Error occurred in Python: No symbol "vmap_area_list" in current context.
> 
> So we can instead use vmap_nodes to iterate all vmallocinfo.
> 
> Link: https://lkml.kernel.org/r/20240207085856.11190-1-Kuan-Ying.Lee@mediatek.com
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> Cc: Casper Li <casper.li@mediatek.com>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Chinwen Chang <chinwen.chang@mediatek.com>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Kieran Bingham <kbingham@kernel.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Qun-Wei Lin <qun-wei.lin@mediatek.com>
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  scripts/gdb/linux/vmalloc.py |   56 +++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 27 deletions(-)
> 
> --- a/scripts/gdb/linux/vmalloc.py~scripts-gdb-vmalloc-fix-vmallocinfo-error
> +++ a/scripts/gdb/linux/vmalloc.py
> @@ -29,32 +29,34 @@ class LxVmallocInfo(gdb.Command):
>          if not constants.LX_CONFIG_MMU:
>              raise gdb.GdbError("Requires MMU support")
>  
> -        vmap_area_list = gdb.parse_and_eval('vmap_area_list')
> -        for vmap_area in lists.list_for_each_entry(vmap_area_list, vmap_area_ptr_type, "list"):
> -            if not vmap_area['vm']:
> -                gdb.write("0x%x-0x%x %10d vm_map_ram\n" % (vmap_area['va_start'], vmap_area['va_end'],
> -                    vmap_area['va_end'] - vmap_area['va_start']))
> -                continue
> -            v = vmap_area['vm']
> -            gdb.write("0x%x-0x%x %10d" % (v['addr'], v['addr'] + v['size'], v['size']))
> -            if v['caller']:
> -                gdb.write(" %s" % str(v['caller']).split(' ')[-1])
> -            if v['nr_pages']:
> -                gdb.write(" pages=%d" % v['nr_pages'])
> -            if v['phys_addr']:
> -                gdb.write(" phys=0x%x" % v['phys_addr'])
> -            if v['flags'] & constants.LX_VM_IOREMAP:
> -                gdb.write(" ioremap")
> -            if v['flags'] & constants.LX_VM_ALLOC:
> -                gdb.write(" vmalloc")
> -            if v['flags'] & constants.LX_VM_MAP:
> -                gdb.write(" vmap")
> -            if v['flags'] & constants.LX_VM_USERMAP:
> -                gdb.write(" user")
> -            if v['flags'] & constants.LX_VM_DMA_COHERENT:
> -                gdb.write(" dma-coherent")
> -            if is_vmalloc_addr(v['pages']):
> -                gdb.write(" vpages")
> -            gdb.write("\n")
> +        nr_vmap_nodes = gdb.parse_and_eval('nr_vmap_nodes')
> +        for i in range(0, nr_vmap_nodes):
> +            vn = gdb.parse_and_eval('&vmap_nodes[%d]' % i)
> +            for vmap_area in lists.list_for_each_entry(vn['busy']['head'], vmap_area_ptr_type, "list"):
> +                if not vmap_area['vm']:
> +                    gdb.write("0x%x-0x%x %10d vm_map_ram\n" % (vmap_area['va_start'], vmap_area['va_end'],
> +                        vmap_area['va_end'] - vmap_area['va_start']))
> +                    continue
> +                v = vmap_area['vm']
> +                gdb.write("0x%x-0x%x %10d" % (v['addr'], v['addr'] + v['size'], v['size']))
> +                if v['caller']:
> +                    gdb.write(" %s" % str(v['caller']).split(' ')[-1])
> +                if v['nr_pages']:
> +                    gdb.write(" pages=%d" % v['nr_pages'])
> +                if v['phys_addr']:
> +                    gdb.write(" phys=0x%x" % v['phys_addr'])
> +                if v['flags'] & constants.LX_VM_IOREMAP:
> +                    gdb.write(" ioremap")
> +                if v['flags'] & constants.LX_VM_ALLOC:
> +                    gdb.write(" vmalloc")
> +                if v['flags'] & constants.LX_VM_MAP:
> +                    gdb.write(" vmap")
> +                if v['flags'] & constants.LX_VM_USERMAP:
> +                    gdb.write(" user")
> +                if v['flags'] & constants.LX_VM_DMA_COHERENT:
> +                    gdb.write(" dma-coherent")
> +                if is_vmalloc_addr(v['pages']):
> +                    gdb.write(" vpages")
> +                gdb.write("\n")
>  
>  LxVmallocInfo()
> _
> 
Thanks for fixing and helping!

--
Uladzislau Rezki

