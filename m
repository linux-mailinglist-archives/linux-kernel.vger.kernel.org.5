Return-Path: <linux-kernel+bounces-15288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608CA8229C1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AE9CB22C96
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCAD182A7;
	Wed,  3 Jan 2024 08:51:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mta.juntadeandalucia.es (mta6.juntadeandalucia.es [217.12.26.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40B618049
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=juntadeandalucia.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juntadeandalucia.es
Received: from [10.240.225.252] (helo=mail.juntadeandalucia.es)
	by ccodis04.juntadeandalucia.es with esmtp (Exim 4.94.2)
	(envelope-from <luis.munoz.edu@juntadeandalucia.es>)
	id 1rKwxj-0002Ar-MM
	for linux-kernel@vger.kernel.org; Wed, 03 Jan 2024 09:50:55 +0100
Received: from [213.194.128.62] (helo=[192.168.1.148])
	by mail.juntadeandalucia.es with esmtpa (Exim 4.94.2)
	(envelope-from <luis.munoz.edu@juntadeandalucia.es>)
	id 1rKwxj-00072n-7V; Wed, 03 Jan 2024 09:50:55 +0100
Message-ID: <ea2f0a37-9691-4595-bcb3-881e29d83ee0@juntadeandalucia.es>
Date: Wed, 3 Jan 2024 09:50:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: I can't activate term(e) and kill(i) magic SysRq key
To: Christian Kujau <lists@nerdbynature.de>
Cc: linux-kernel@vger.kernel.org
References: <002cc4da-e502-4c79-97bd-0a8b6cb2630c@juntadeandalucia.es>
 <464f7af8-d83d-d2e3-c635-772ed6a3cb54@nerdbynature.de>
Content-Language: es-ES
From: =?UTF-8?Q?Luis_Mu=C3=B1oz_Fuente?= <luis.munoz.edu@juntadeandalucia.es>
In-Reply-To: <464f7af8-d83d-d2e3-c635-772ed6a3cb54@nerdbynature.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 182453 [Jan 03 2024]
X-KLMS-AntiSpam-Version: 6.1.0.3
X-KLMS-AntiSpam-Envelope-From: luis.munoz.edu@juntadeandalucia.es
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s, ApMailHostAddress: 213.194.128.62
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2024/01/03 07:02:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/01/03 05:32:00 #22946033
X-KLMS-AntiVirus-Status: Clean, skipped


El 2/1/24 a las 21:45, Christian Kujau escribió:
> Maybe. Some distributions choose to disable certain sysrq functions. See 
> the page you cited, on the very top: what does "sysctl kernel.sysrq" say? 
> If it's anything but "1", certain or all sysrq functions are disabled.

Hello:
I had gotten involved. I was looking at the option the kernel was
compiled with by default:
grep -i CONFIG_MAGIC_SYSRQ /boot/my_kernel
instead of looking at what option I had chosen:
cat /proc/sys/kernel/sysrq
Thank you


