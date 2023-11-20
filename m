Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FB17F110C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjKTK7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjKTK66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:58:58 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71529C;
        Mon, 20 Nov 2023 02:58:54 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5bddf66ed63so2877690a12.1;
        Mon, 20 Nov 2023 02:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700477934; x=1701082734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hss0DScungQG3wuEN+tDn4zevM2VhdEJWx+ngv2QB2g=;
        b=h5alUNaa6bBArrEjXy7zfYJ9s2J+tMGXyqjDyzHuPWqFJK4Dt/RXUtIGQyeS5S0sU6
         FSqLZPUpyXNK1nWFqJb/G1hxBQOVIj9II/nOQE/Tgr8GHgWeZbcrNfQW8TsU24fIS2wL
         hxTkVD8en2hMoLSk8xR6n7H6uT21hzwQzmS0sVxyuPOgbc61giqFLm5tesF1Sm8o5X8A
         JYCEvP6c3RGsXTKdpk1k09R0Xl0u7vwZX/+MUFCf8O4XFA5X8MFK6ElFGWmd+wFyBqrK
         HLMmZEP6Ip9cIu9vklH9FJdEm8I4bGz7NgHejFa5O1QzVBJlMmzjyhIXxMM/CTmwmaGV
         KTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700477934; x=1701082734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hss0DScungQG3wuEN+tDn4zevM2VhdEJWx+ngv2QB2g=;
        b=VsgoOMU+hxuyvKt3gGaMQgz05ChbYmyvbebv41ezDNDr18i64lOSSq1oVPvsn2/riv
         aUjt5hi2RE03jICFRy/jXmneD1vxKsqxPj4CPHgruXXqhiOHXBhoTqUUeAOXBPHG4emG
         UE/oPGcEkeYxiJApI9vUV2+1yIT6E8s30UBl2z/EHyL15x2xPd8S6Ktp8VWFooNawp1I
         fw7fqbQnM3KzROJ7htg0RVhJYuhs6jcS7jhGzo+29yfHKxESibxRUkSCX68oXcruE1KR
         vNYA8dxWfhKtrD6/fqwrjg/r6MY7FKX9oqLkpg6h+cAhPqan6FiU/G6LlDPdXKqt53VL
         riog==
X-Gm-Message-State: AOJu0YyaZyv7Rh4K1DanXgTeYd9JMiEa3SQJ9kCQEf+ObGxEWoXCSYGT
        8Ja9klLM1epqptWLNYD+lUI=
X-Google-Smtp-Source: AGHT+IE0ir36wseZ1ERuTn6WVBZ2hZ9lSDF8lyMELvj+kI6imXtdURMceGktUBcNOEOyuiWaZcapPg==
X-Received: by 2002:a05:6a20:3d87:b0:187:2b7b:1b87 with SMTP id s7-20020a056a203d8700b001872b7b1b87mr9778084pzi.21.1700477933855;
        Mon, 20 Nov 2023 02:58:53 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id v10-20020aa7850a000000b006be4bb0d2dcsm6010021pfn.149.2023.11.20.02.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 02:58:53 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 667ED101D8174; Mon, 20 Nov 2023 17:58:51 +0700 (WIB)
Date:   Mon, 20 Nov 2023 17:58:51 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Yi-De Wu <yi-de.wu@mediatek.com>,
        Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        David Bradil <dbrazdil@google.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Jade Shih <jades.shih@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>,
        Willix Yeh <chi-shen.yeh@mediatek.com>,
        Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Subject: Re: [PATCH v7 01/16] docs: geniezone: Introduce GenieZone hypervisor
Message-ID: <ZVs760ggqT-erCji@archie.me>
References: <20231116152756.4250-1-yi-de.wu@mediatek.com>
 <20231116152756.4250-2-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231116152756.4250-2-yi-de.wu@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 11:27:41PM +0800, Yi-De Wu wrote:
> diff --git a/Documentation/virt/geniezone/introduction.rst b/Documentation/virt/geniezone/introduction.rst
> new file mode 100644
> index 000000000000..fb9fa41bcfb8
> --- /dev/null
> +++ b/Documentation/virt/geniezone/introduction.rst
> @@ -0,0 +1,86 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======================
> +GenieZone Introduction
> +======================
> +
> +Overview
> +========
> +GenieZone hypervisor(gzvm) is a type-1 hypervisor that supports various virtual
"... hypervisor (gzvm) ..."
> +machine types and provides security features such as TEE-like scenarios and
> +secure boot. It can create guest VMs for security use cases and has
> +virtualization capabilities for both platform and interrupt. Although the
> +hypervisor can be booted independently, it requires the assistance of GenieZone
> +hypervisor kernel driver(gzvm-ko) to leverage the ability of Linux kernel for
"hypervisor kernel driver (also named gzvm) ..."
> +vCPU scheduling, memory management, inter-VM communication and virtio backend
> +support.
> +
> +Supported Architecture
> +======================
> +GenieZone now only supports MediaTek ARM64 SoC.
> +
> +Features
> +========
> +
> +- vCPU Management
> +
> +VM manager aims to provide vCPUs on the basis of time sharing on physical CPUs.
> +It requires Linux kernel in host VM for vCPU scheduling and VM power management.
> +
> +- Memory Management
> +
> +Direct use of physical memory from VMs is forbidden and designed to be dictated
> +to the privilege models managed by GenieZone hypervisor for security reason.
> +With the help of gzvm-ko, the hypervisor would be able to manipulate memory as

s/gzvm-ko/gzvm module/g

> +objects.
> +
> +- Virtual Platform
> +
> +We manage to emulate a virtual mobile platform for guest OS running on guest
> +VM. The platform supports various architecture-defined devices, such as
> +virtual arch timer, GIC, MMIO, PSCI, and exception watching...etc.
> +
> +- Inter-VM Communication
> +
> +Communication among guest VMs was provided mainly on RPC. More communication
> +mechanisms were to be provided in the future based on VirtIO-vsock.
> +
> +- Device Virtualization
> +
> +The solution is provided using the well-known VirtIO. The gzvm-ko would
> +redirect MMIO traps back to VMM where the virtual devices are mostly emulated.
> +Ioeventfd is implemented using eventfd for signaling host VM that some IO
> +events in guest VMs need to be processed.
> +
> +- Interrupt virtualization
> +
> +All Interrupts during some guest VMs running would be handled by GenieZone
> +hypervisor with the help of gzvm-ko, both virtual and physical ones. In case
> +there's no guest VM running out there, physical interrupts would be handled by
> +host VM directly for performance reason. Irqfd is also implemented using
> +eventfd for accepting vIRQ requests in gzvm-ko.
> +
> +Platform architecture component
> +===============================
> +
> +- vm
> +
> +The vm component is responsible for setting up the capability and memory
> +management for the protected VMs. The capability is mainly about the lifecycle
> +control and boot context initialization. And the memory management is highly
> +integrated with ARM 2-stage translation tables to convert VA to IPA to PA under
> +proper security measures required by protected VMs.
> +
> +- vcpu
> +
> +The vcpu component is the core of virtualizing aarch64 physical CPU runnable,
> +and it controls the vCPU lifecycle including creating, running and destroying.
> +With self-defined exit handler, the vm component would be able to act
> +accordingly before terminated.
> +
> +- vgic
> +
> +The vgic component exposes control interfaces to Linux kernel via irqchip, and
> +we intend to support all SPI, PPI, and SGI. When it comes to virtual
> +interrupts, the GenieZone hypervisor would write to list registers and trigger
> +vIRQ injection in guest VMs via GIC.

Descriptions for feature lists can be aligned:

---- >8 ----
diff --git a/Documentation/virt/geniezone/introduction.rst b/Documentation/virt/geniezone/introduction.rst
index fb9fa41bcfb8b3..f37ddf4e979992 100644
--- a/Documentation/virt/geniezone/introduction.rst
+++ b/Documentation/virt/geniezone/introduction.rst
@@ -24,63 +24,64 @@ Features
 
 - vCPU Management
 
-VM manager aims to provide vCPUs on the basis of time sharing on physical CPUs.
-It requires Linux kernel in host VM for vCPU scheduling and VM power management.
+  VM manager aims to provide vCPUs on the basis of time sharing on physical
+  CPUs. It requires Linux kernel in host VM for vCPU scheduling and VM power
+  management.
 
 - Memory Management
 
-Direct use of physical memory from VMs is forbidden and designed to be dictated
-to the privilege models managed by GenieZone hypervisor for security reason.
-With the help of gzvm-ko, the hypervisor would be able to manipulate memory as
-objects.
+  Direct use of physical memory from VMs is forbidden and designed to be
+  dictated to the privilege models managed by GenieZone hypervisor for security
+  reason. With the help of gzvm-ko, the hypervisor would be able to manipulate
+  memory as objects.
 
 - Virtual Platform
 
-We manage to emulate a virtual mobile platform for guest OS running on guest
-VM. The platform supports various architecture-defined devices, such as
-virtual arch timer, GIC, MMIO, PSCI, and exception watching...etc.
+  We manage to emulate a virtual mobile platform for guest OS running on guest
+  VM. The platform supports various architecture-defined devices, such as
+  virtual arch timer, GIC, MMIO, PSCI, and exception watching...etc.
 
 - Inter-VM Communication
 
-Communication among guest VMs was provided mainly on RPC. More communication
-mechanisms were to be provided in the future based on VirtIO-vsock.
+  Communication among guest VMs was provided mainly on RPC. More communication
+  mechanisms were to be provided in the future based on VirtIO-vsock.
 
 - Device Virtualization
 
-The solution is provided using the well-known VirtIO. The gzvm-ko would
-redirect MMIO traps back to VMM where the virtual devices are mostly emulated.
-Ioeventfd is implemented using eventfd for signaling host VM that some IO
-events in guest VMs need to be processed.
+  The solution is provided using the well-known VirtIO. The gzvm-ko would
+  redirect MMIO traps back to VMM where the virtual devices are mostly
+  emulated. Ioeventfd is implemented using eventfd for signaling host VM that
+  some IO events in guest VMs need to be processed.
 
 - Interrupt virtualization
 
-All Interrupts during some guest VMs running would be handled by GenieZone
-hypervisor with the help of gzvm-ko, both virtual and physical ones. In case
-there's no guest VM running out there, physical interrupts would be handled by
-host VM directly for performance reason. Irqfd is also implemented using
-eventfd for accepting vIRQ requests in gzvm-ko.
+  All Interrupts during some guest VMs running would be handled by GenieZone
+  hypervisor with the help of gzvm-ko, both virtual and physical ones. In case
+  there's no guest VM running out there, physical interrupts would be handled
+  by host VM directly for performance reason. Irqfd is also implemented using
+  eventfd for accepting vIRQ requests in gzvm-ko.
 
 Platform architecture component
 ===============================
 
 - vm
 
-The vm component is responsible for setting up the capability and memory
-management for the protected VMs. The capability is mainly about the lifecycle
-control and boot context initialization. And the memory management is highly
-integrated with ARM 2-stage translation tables to convert VA to IPA to PA under
-proper security measures required by protected VMs.
+  The vm component is responsible for setting up the capability and memory
+  management for the protected VMs. The capability is mainly about the
+  lifecycle control and boot context initialization. And the memory management
+  is highly integrated with ARM 2-stage translation tables to convert VA to IPA
+  to PA under proper security measures required by protected VMs.
 
 - vcpu
 
-The vcpu component is the core of virtualizing aarch64 physical CPU runnable,
-and it controls the vCPU lifecycle including creating, running and destroying.
-With self-defined exit handler, the vm component would be able to act
-accordingly before terminated.
+  The vcpu component is the core of virtualizing aarch64 physical CPU runnable,
+  and it controls the vCPU lifecycle including creating, running and
+  destroying. With self-defined exit handler, the vm component would be able to
+  act accordingly before terminated.
 
 - vgic
 
-The vgic component exposes control interfaces to Linux kernel via irqchip, and
-we intend to support all SPI, PPI, and SGI. When it comes to virtual
-interrupts, the GenieZone hypervisor would write to list registers and trigger
-vIRQ injection in guest VMs via GIC.
+  The vgic component exposes control interfaces to Linux kernel via irqchip,
+  and we intend to support all SPI, PPI, and SGI. When it comes to virtual
+  interrupts, the GenieZone hypervisor would write to list registers and
+  trigger vIRQ injection in guest VMs via GIC.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
