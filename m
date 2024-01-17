Return-Path: <linux-kernel+bounces-29471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D5D830EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C2B1B2511B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C27F25628;
	Wed, 17 Jan 2024 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5PnqrZF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39CF25576;
	Wed, 17 Jan 2024 21:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705528045; cv=none; b=GFUvzCS+W4lTqCcwJU5cIgOtlee5zIpR0vhdZzHQWT981LZYt18XxePmOQ5/NXW/buH9aFfVVTT70WMwyrlMpTGgODsuoAMreSWMZFNZ5SRPLX5A5hHBdKPbmS07PlBAHbtuM+Hbl/3o3J+0J77CvEp+ib1aoxGwe7kkpeoAaoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705528045; c=relaxed/simple;
	bh=U4KCExeegPVmyl5fHGwSouCkiU5m1FcqJKiTiOHYwi8=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=T8vJ9qsoKgsb0aY4nxiQD5e7C+3pB0n4tlGZry2oRo0rdAFlg3eKjbxSFj1Zd/v8dK+jTObKM43ZfR9f/rip1o24cmKHgVbpBl8pcilkebW5nIPghE7O5pMycdJc0EAaR/liGANYUb2aApCxojQzZZNYp8K8TgDQMvZs+PiEOx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5PnqrZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4D0C43390;
	Wed, 17 Jan 2024 21:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705528044;
	bh=U4KCExeegPVmyl5fHGwSouCkiU5m1FcqJKiTiOHYwi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F5PnqrZFw+MyDBpLNsFvOhQ12RyUDQ9HtD1p05GlSe5DQbHndS1ONazqXQ/IDsUUM
	 27u01Oe4oehgftyiasaZVJ0TFeVSIKGXVCOn0/T/NTCmt1ZEOLT7pJgG6vAKtvX+c9
	 uvvqZapyiF4DogneSXXIRe2bUoXTNO8eVFcokvA0qW+Il1Xb4o7zWKwJsYchJTJXB7
	 mgH5lazJOfJRnJxeSbEErwl69leX18yBzs8StCd6XDAKHVFyrEnRaEgFWPhgDGy8Wg
	 fqB7o1++0XzV9G6JdngYZW2HCQTUaCa04DVyroo6h07Bo5usccTSB9AB2vPjsnPwOO
	 r1dmJjxmC0lMQ==
Date: Wed, 17 Jan 2024 15:47:22 -0600
From: Rob Herring <robh@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
Subject: Re: [PATCH v3] dt-bindings: fpga: Convert fpga-region binding to yaml
Message-ID: <20240117214722.GA3176505-robh@kernel.org>
References: <4d87561dcbfab9e4818d7ad99caf89938774a839.1705491050.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d87561dcbfab9e4818d7ad99caf89938774a839.1705491050.git.michal.simek@amd.com>

On Wed, Jan 17, 2024 at 12:30:58PM +0100, Michal Simek wrote:
> Convert the generic fpga region DT binding to json-schema.
> There are some differences compare to txt version.
> 1. DT overlay can't be described in example that's why directly include
> information from overlay to node which was referenced. It is visible in
> example with /* DT Overlay contains: &... */
> 
> 2. All example have been rewritten to be simpler and describe only full
> reconfiguration and partial reconfiguration with one bridge.
> Completely drop the case where fpga region can inside partial
> reconfiguration region which is already described in description
> 
> 3. Fixed some typos in descriptions compare to txt version but most of it
> is just c&p from txt file.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v3:
> - drop fpga bridge and mgr descriptions in example
> - use additionalProperties: true
> - use fixed-factor-clock instead
> - fixed matching pattern
> 
> Changes in v2:
> - Fix typo in subject
> - Fix comment in bridge example
> - Change license back to gpl-2.0 only
> - Do not define firware-name type and add maxItems 1
> - Make fpga-bridge phandle-array
> - Drop ranges property because of missing reg property of fpga-region
> - Also describe case with fixed clock node and axi bus
> - Fix fpga-region names in example
> 
> Please let me know if there is a way to describe overlays to dt root to be
> able to reference fpga region back.

No. Overlays are somewhat outside the scope of schema. Certainly not 
supported in the examples. When the dts files are free of warnings I'll 
worry about overlays. :)

> ---
>  .../devicetree/bindings/fpga/fpga-region.txt  | 479 ------------------
>  .../devicetree/bindings/fpga/fpga-region.yaml | 351 +++++++++++++
>  2 files changed, 351 insertions(+), 479 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/fpga/fpga-region.txt
>  create mode 100644 Documentation/devicetree/bindings/fpga/fpga-region.yaml


> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.yaml b/Documentation/devicetree/bindings/fpga/fpga-region.yaml
> new file mode 100644
> index 000000000000..fb6fe6f43fa8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.yaml
> @@ -0,0 +1,351 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/fpga-region.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: FPGA Region
> +
> +maintainers:
> +  - Michal Simek <michal.simek@amd.com>
> +
> +description: |
> +  CONTENTS
> +   - Introduction
> +   - Terminology
> +   - Sequence
> +   - FPGA Region
> +   - Supported Use Models
> +   - Constraints
> +
> +
> +  Introduction
> +  ============
> +
> +  FPGA Regions represent FPGA's and partial reconfiguration regions of FPGA's in
> +  the Device Tree.  FPGA Regions provide a way to program FPGAs under device tree
> +  control.
> +
> +  The documentation hits some of the high points of FPGA usage and
> +  attempts to include terminology used by both major FPGA manufacturers.  This
> +  document isn't a replacement for any manufacturers specifications for FPGA
> +  usage.
> +
> +
> +  Terminology
> +  ===========
> +
> +  Full Reconfiguration
> +   * The entire FPGA is programmed.
> +
> +  Partial Reconfiguration (PR)
> +   * A section of an FPGA is reprogrammed while the rest of the FPGA is not
> +     affected.
> +   * Not all FPGA's support PR.
> +
> +  Partial Reconfiguration Region (PRR)
> +   * Also called a "reconfigurable partition"
> +   * A PRR is a specific section of an FPGA reserved for reconfiguration.
> +   * A base (or static) FPGA image may create a set of PRR's that later may
> +     be independently reprogrammed many times.
> +   * The size and specific location of each PRR is fixed.
> +   * The connections at the edge of each PRR are fixed.  The image that is loaded
> +     into a PRR must fit and must use a subset of the region's connections.
> +   * The busses within the FPGA are split such that each region gets its own
> +     branch that may be gated independently.
> +
> +  Persona
> +   * Also called a "partial bit stream"
> +   * An FPGA image that is designed to be loaded into a PRR.  There may be
> +     any number of personas designed to fit into a PRR, but only one at a time
> +     may be loaded.
> +   * A persona may create more regions.
> +
> +  FPGA Bridge
> +   * FPGA Bridges gate bus signals between a host and FPGA.
> +   * FPGA Bridges should be disabled while the FPGA is being programmed to
> +     prevent spurious signals on the cpu bus and to the soft logic.
> +   * FPGA bridges may be actual hardware or soft logic on an FPGA.
> +   * During Full Reconfiguration, hardware bridges between the host and FPGA
> +     will be disabled.
> +   * During Partial Reconfiguration of a specific region, that region's bridge
> +     will be used to gate the busses.  Traffic to other regions is not affected.
> +   * In some implementations, the FPGA Manager transparently handles gating the
> +     buses, eliminating the need to show the hardware FPGA bridges in the
> +     device tree.
> +   * An FPGA image may create a set of reprogrammable regions, each having its
> +     own bridge and its own split of the busses in the FPGA.
> +
> +  FPGA Manager
> +   * An FPGA Manager is a hardware block that programs an FPGA under the control
> +     of a host processor.
> +
> +  Base Image
> +   * Also called the "static image"
> +   * An FPGA image that is designed to do full reconfiguration of the FPGA.
> +   * A base image may set up a set of partial reconfiguration regions that may
> +     later be reprogrammed.
> +
> +      ----------------       ----------------------------------
> +      |  Host CPU    |       |             FPGA               |
> +      |              |       |                                |
> +      |          ----|       |       -----------    --------  |
> +      |          | H |       |   |==>| Bridge0 |<==>| PRR0 |  |
> +      |          | W |       |   |   -----------    --------  |
> +      |          |   |       |   |                            |
> +      |          | B |<=====>|<==|   -----------    --------  |
> +      |          | R |       |   |==>| Bridge1 |<==>| PRR1 |  |
> +      |          | I |       |   |   -----------    --------  |
> +      |          | D |       |   |                            |
> +      |          | G |       |   |   -----------    --------  |
> +      |          | E |       |   |==>| Bridge2 |<==>| PRR2 |  |
> +      |          ----|       |       -----------    --------  |
> +      |              |       |                                |
> +      ----------------       ----------------------------------
> +
> +  Figure 1: An FPGA set up with a base image that created three regions.  Each
> +  region (PRR0-2) gets its own split of the busses that is independently gated by
> +  a soft logic bridge (Bridge0-2) in the FPGA.  The contents of each PRR can be
> +  reprogrammed independently while the rest of the system continues to function.
> +
> +
> +  Sequence
> +  ========
> +
> +  When a DT overlay that targets an FPGA Region is applied, the FPGA Region will
> +  do the following:
> +
> +   1. Disable appropriate FPGA bridges.
> +   2. Program the FPGA using the FPGA manager.
> +   3. Enable the FPGA bridges.
> +   4. The Device Tree overlay is accepted into the live tree.
> +   5. Child devices are populated.
> +
> +  When the overlay is removed, the child nodes will be removed and the FPGA Region
> +  will disable the bridges.
> +
> +
> +  FPGA Region
> +  ===========
> +
> +  FPGA Regions represent FPGA's and FPGA PR regions in the device tree.  An FPGA
> +  Region brings together the elements needed to program on a running system and
> +  add the child devices:
> +
> +   * FPGA Manager
> +   * FPGA Bridges
> +   * image-specific information needed to the programming.
> +   * child nodes
> +
> +  The intended use is that a Device Tree overlay (DTO) can be used to reprogram an
> +  FPGA while an operating system is running.
> +
> +  An FPGA Region that exists in the live Device Tree reflects the current state.
> +  If the live tree shows a "firmware-name" property or child nodes under an FPGA
> +  Region, the FPGA already has been programmed.  A DTO that targets an FPGA Region
> +  and adds the "firmware-name" property is taken as a request to reprogram the
> +  FPGA.  After reprogramming is successful, the overlay is accepted into the live
> +  tree.
> +
> +  The base FPGA Region in the device tree represents the FPGA and supports full
> +  reconfiguration.  It must include a phandle to an FPGA Manager.  The base
> +  FPGA region will be the child of one of the hardware bridges (the bridge that
> +  allows register access) between the cpu and the FPGA.  If there are more than
> +  one bridge to control during FPGA programming, the region will also contain a
> +  list of phandles to the additional hardware FPGA Bridges.
> +
> +  For partial reconfiguration (PR), each PR region will have an FPGA Region.
> +  These FPGA regions are children of FPGA bridges which are then children of the
> +  base FPGA region.  The "Full Reconfiguration to add PRR's" example below shows
> +  this.
> +
> +  If an FPGA Region does not specify an FPGA Manager, it will inherit the FPGA
> +  Manager specified by its ancestor FPGA Region.  This supports both the case
> +  where the same FPGA Manager is used for all of an FPGA as well the case where
> +  a different FPGA Manager is used for each region.
> +
> +  FPGA Regions do not inherit their ancestor FPGA regions' bridges.  This prevents
> +  shutting down bridges that are upstream from the other active regions while one
> +  region is getting reconfigured (see Figure 1 above).  During PR, the FPGA's
> +  hardware bridges remain enabled.  The PR regions' bridges will be FPGA bridges
> +  within the static image of the FPGA.
> +
> +
> +  Supported Use Models
> +  ====================
> +
> +  In all cases the live DT must have the FPGA Manager, FPGA Bridges (if any), and
> +  a FPGA Region.  The target of the Device Tree Overlay is the FPGA Region.  Some
> +  uses are specific to an FPGA device.
> +
> +   * No FPGA Bridges
> +     In this case, the FPGA Manager which programs the FPGA also handles the
> +     bridges behind the scenes.  No FPGA Bridge devices are needed for full
> +     reconfiguration.
> +
> +   * Full reconfiguration with hardware bridges
> +     In this case, there are hardware bridges between the processor and FPGA that
> +     need to be controlled during full reconfiguration.  Before the overlay is
> +     applied, the live DT must include the FPGA Manager, FPGA Bridges, and a
> +     FPGA Region.  The FPGA Region is the child of the bridge that allows
> +     register access to the FPGA.  Additional bridges may be listed in a
> +     fpga-bridges property in the FPGA region or in the device tree overlay.
> +
> +   * Partial reconfiguration with bridges in the FPGA
> +     In this case, the FPGA will have one or more PRR's that may be programmed
> +     separately while the rest of the FPGA can remain active.  To manage this,
> +     bridges need to exist in the FPGA that can gate the buses going to each FPGA
> +     region while the buses are enabled for other sections.  Before any partial
> +     reconfiguration can be done, a base FPGA image must be loaded which includes
> +     PRR's with FPGA bridges.  The device tree should have an FPGA region for each
> +     PRR.
> +
> +  Constraints
> +  ===========
> +
> +  It is beyond the scope of this document to fully describe all the FPGA design
> +  constraints required to make partial reconfiguration work[1] [2] [3], but a few
> +  deserve quick mention.
> +
> +  A persona must have boundary connections that line up with those of the partition
> +  or region it is designed to go into.
> +
> +  During programming, transactions through those connections must be stopped and
> +  the connections must be held at a fixed logic level.  This can be achieved by
> +  FPGA Bridges that exist on the FPGA fabric prior to the partial reconfiguration.
> +
> +  --
> +  [1] www.altera.com/content/dam/altera-www/global/en_US/pdfs/literature/ug/ug_partrecon.pdf
> +  [2] tspace.library.utoronto.ca/bitstream/1807/67932/1/Byma_Stuart_A_201411_MAS_thesis.pdf
> +  [3] https://www.xilinx.com/support/documentation/sw_manuals/xilinx14_1/ug702.pdf
> +
> +properties:
> +  $nodename:
> +    pattern: "^fpga-region(-([0-9]|[1-9][0-9]+))?$"
> +
> +  compatible:
> +    const: fpga-region
> +
> +  "#address-cells": true
> +  "#size-cells": true
> +
> +  config-complete-timeout-us:
> +    description:
> +      The maximum time in microseconds time for the FPGA to go to operating
> +      mode after the region has been programmed.
> +
> +  encrypted-fpga-config:
> +    type: boolean
> +    description:
> +      Set if the bitstream is encrypted.
> +
> +  external-fpga-config:
> +    type: boolean
> +    description:
> +      Set if the FPGA has already been configured prior to OS boot up.
> +
> +  firmware-name:
> +    maxItems: 1
> +    description:
> +      Should contain the name of an FPGA image file located on the firmware
> +      search path. If this property shows up in a live device tree it indicates
> +      that the FPGA has already been programmed with this image.
> +      If this property is in an overlay targeting an FPGA region, it is
> +      a request to program the FPGA with that image.
> +
> +  fpga-bridges:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      Should contain a list of phandles to FPGA Bridges that must be
> +      controlled during FPGA programming along with the parent FPGA bridge.
> +      This property is optional if the FPGA Manager handles the bridges.
> +      If the fpga-region is  the child of an fpga-bridge, the list should not
> +      contain the parent bridge.
> +
> +  fpga-mgr:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Should contain a phandle to an FPGA Manager.  Child FPGA Regions
> +      inherit this property from their ancestor regions.  An fpga-mgr property
> +      in a region will override any inherited FPGA manager.
> +
> +  partial-fpga-config:
> +    type: boolean
> +    description:
> +      Set if partial reconfiguration is to be done, otherwise full
> +      reconfiguration is done.
> +
> +  region-freeze-timeout-us:
> +    description:
> +      The maximum time in microseconds to wait for bridges to successfully
> +      become disabled before the region has been programmed.
> +
> +  region-unfreeze-timeout-us:
> +    description:
> +      The maximum time in microseconds to wait for bridges to successfully
> +      become enabled after the region has been programmed.
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +  - fpga-mgr
> +
> +additionalProperties: true

Why? This should only be used if another schema is going to include this 
one. That's not the case here.

'type: object' would be acceptable here as that says only nodes can be 
added.

> +
> +examples:
> +  - |
> +    /*
> +     * Full Reconfiguration without Bridges with DT overlay
> +     */
> +    fpga_region0: fpga-region {

Drop unused labels.

> +      compatible = "fpga-region";
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      fpga-mgr = <&fpga_mgr0>;
> +
> +      /* DT Overlay contains: &fpga_region0 */
> +      firmware-name = "zynq-gpio.bin";
> +      gpio@40000000 {
> +        compatible = "xlnx,xps-gpio-1.00.a";
> +        reg = <0x40000000 0x10000>;

This example implies this is a translatable address, but the lack of 
'ranges' in the parent prevents that. In turn, that means unit-addresses 
should be accepted in the parent node name as well.

Rob

