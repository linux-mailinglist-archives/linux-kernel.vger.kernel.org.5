Return-Path: <linux-kernel+bounces-110639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBEA88619A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600A31F22E82
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6589134CEF;
	Thu, 21 Mar 2024 20:26:35 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C96F134CC6;
	Thu, 21 Mar 2024 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711052795; cv=none; b=imXAEXKiuIKwXFPPpttxVBdHH1VTez4vu1wRkN87xs0UlETV8ggI99u1osOHOWe6SvyfQ2wPyxUHYZfgaLtd8p7HIp2rTDsEHgryW5hiN+A04dWJ3rIQPeSegigQeMh67iBhzhusRnocGmqJUIiyCBJ9nf6Nag36rmsf8nIKEBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711052795; c=relaxed/simple;
	bh=N64rGhvs2KBoM27OkS7eZxDXNsg40ICyXB3VDM12Icc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loM5sa3WVA4pZLdqePuXSP2AiYTQ5seG+NHB0hrmneq/4cCzZxjR/J/LULYKHs7PcdYyUwLgGDXghQ1Cp3Df+KsOJ7Udgb97I18vmLrisa3ouzwACDfjx275gMNZhFQSv/a0AVbREa+jasUw3AYfQZgjPWMMfE0CUc62Zk1fGcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rnOzL-0000Zb-2X;
	Thu, 21 Mar 2024 20:26:11 +0000
Date: Thu, 21 Mar 2024 20:26:07 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	Christian Heusel <christian@heusel.eu>,
	Min Li <min15.li@samsung.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <avri.altman@wdc.com>, Hannes Reinecke <hare@suse.de>,
	Christian Loehle <CLoehle@hyperstone.com>,
	Bean Huo <beanhuo@micron.com>, Yeqi Fu <asuk4.q@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: block: add basic bindings for block
 devices
Message-ID: <ZfyX36JH0NdqS1AW@makrotopia.org>
References: <cover.1711048433.git.daniel@makrotopia.org>
 <28dcc69ecf9d55e95991d8f2a8e19f71bbd32af0.1711048433.git.daniel@makrotopia.org>
 <38efd4e4-0421-4318-8b2d-ca2603d482f5@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38efd4e4-0421-4318-8b2d-ca2603d482f5@acm.org>

On Thu, Mar 21, 2024 at 12:39:33PM -0700, Bart Van Assche wrote:
> On 3/21/24 12:32, Daniel Golle wrote:
> > +$id: http://devicetree.org/schemas/block/partition.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Partition on a block device
> > +
> > +description: |
> > +  This binding describes a partition on a block device.
> > +  Partitions may be matched by a combination of partition number, name,
> > +  and UUID.
> > +
> > +maintainers:
> > +  - Daniel Golle <daniel@makrotopia.org>
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: '^block-partition-.+$'
> > +
> > +  partnum:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Matches partition by number if present.
> > +
> > +  partname:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description:
> > +      Matches partition by PARTNAME if present.
> > +
> > +  partuuid:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description:
> > +      Matches partition by PARTUUID if present.
> > +
> > +  nvmem-layout:
> > +    $ref: /schemas/nvmem/layouts/nvmem-layout.yaml#
> > +    description:
> > +      This container may reference an NVMEM layout parser.
> 
> Does the above imply that only systems with a single block device are
> supported?

Absolutely not. Of course also such devices often have multiple block
devices, typically eMMC, NVMe and SD card are supported, some also
come with SATA ports. The block device(s) relevant as NVMEM providers
has/have to be referenced and the 'partitions' node is a child node of
a specific block device, of course.

> 
> Supporting partition numbers seems unfortunate to me. Partition numbers
> will change if the partition scheme changes.

I fully argee with that, and using partnum as an identifier is not
very smart. However, this is what some vendors are doing (in custom
downstream drivers or scripts running in early userland) and hence the
kernel implementation should allow to identify the relevant location
in exactly the same way to be sure we are always compatible.

