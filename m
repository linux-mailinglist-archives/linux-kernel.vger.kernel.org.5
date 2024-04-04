Return-Path: <linux-kernel+bounces-132126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE47898FF6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BEAD1C22639
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B70013BAE6;
	Thu,  4 Apr 2024 21:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bq+Y1+PT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A7E13B596;
	Thu,  4 Apr 2024 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265248; cv=none; b=iqyGKmrScWW7qaeKilgJmbTfE1b2M3ZnAUyyCtJEMRKinjoUAzeochLI7NTka1XrFeAO4LN8zI9JhTF+DimT7OimX7ElHUrxIpJ0B2Q354X30QUQt2eJEn659RunPa/BRZ4RZavhLMuaW2lwXDL5K1AB/7WkfGKD16d2dTOVq6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265248; c=relaxed/simple;
	bh=+ymBVH3Io2+0wCbC3WwXzoBoQD9rIjOHKIIOiEpEtjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BASvDnLOwaKSmLs648Fwgia4M96Vtscok/v56/OrgkbPPvEPu4a4sVfNl+F0vOKOmtt69lQMrANRzf36JmzDj3bbMmRkc6K4ZnhpaeQJlE57myfRV3h1MXkyU34STtbQ5hd/Xn6atDn3UAmgxaogBZ7VcCqoflQbnkM3ihlhswI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bq+Y1+PT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0722FC433C7;
	Thu,  4 Apr 2024 21:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712265248;
	bh=+ymBVH3Io2+0wCbC3WwXzoBoQD9rIjOHKIIOiEpEtjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bq+Y1+PTBxQ3zh+H+CjyAirBCEFsOqAChJWAZtC7muYj3JoAU48m3ID/e4FrYPZ7G
	 e5FuD7xwN1fjoX/lO316hGW9iIBkkA2xxWoG6emBMyABd9lsVM+52g4E5Q8GiEVVPB
	 wUc2o6YlbM8ev5edin0zIRpHEPnSDoMqlfnUVkFbxirHj3s3H3sYKy8KCfq+JITJqC
	 U/bVlAL1wq7bNj/yIokdqW0T9lsYLOpfOm/LJ18L7jlWBrVGGZNZ760SeTLR/K5hXW
	 2Z6eahO46qCe9HZn42Ui7kVYEBbfi4NuwZaDZmy4hEA8Y3/VSkmlgw8NI6lccKk3RB
	 9XATq0oAYKJJg==
Date: Thu, 4 Apr 2024 18:14:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	namhyung@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
	sumanthk@linux.ibm.com, hca@linux.ibm.com,
	Ian Rogers <irogers@google.com>
Subject: Re: [Ping PATCH 1/2 v2] perf report: Fix PAI counter names for s390
 virtual machines
Message-ID: <Zg8YHHnospO0OwZ7@x1>
References: <20240404064806.1362876-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404064806.1362876-1-tmricht@linux.ibm.com>

On Thu, Apr 04, 2024 at 08:48:05AM +0200, Thomas Richter wrote:
> s390 introduced Processor Activity Instrumentation (PAI) counter
> facility on LPAR and virtual machines z/VM for models 3931 and 3932.
> These counters are stored as raw data in the perf.data file and are
> displayed with command

Thanks, applied both patches to perf-tools-next.

- Arnaldo

