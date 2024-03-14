Return-Path: <linux-kernel+bounces-103767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB6587C42D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BC79B20B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7CE76414;
	Thu, 14 Mar 2024 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="PxjI9h21"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040DD76053;
	Thu, 14 Mar 2024 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710447564; cv=none; b=GhxfNMA2V8nuT83gmsvLfLGU2iFtlurlffykdUOCLigqChYm125R4+LUw2RMTI/OJ/v+KS7VwHv1Clsp1G9a8c2+ejVqnWvIissKeOie4c+DJ8/K7hOa2qSaFk7ZjcI0T9TF8RSaz4FFd6/ECb9BKxsKOSzx6joJ1qriQIyvFYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710447564; c=relaxed/simple;
	bh=Zu8ZkIHTHljYg5u7isWwTbyb70s/0aIVEDUbtKWGA04=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qpPuXlN2zmJinTaIjzyE2uCiIkZ+JoDoUbpaH6LxmiYG8czEJ8hchnESYgrY3S8hblD//2QxpmwZ3Za0z5VF66y75tVX2BhDT1fBcCw5HnZs8uUvYJQEo3V1FKRsBpJQpXJEIAEPmklOvIoXFA2HkeecV9lieywdlqocx8IWvjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=PxjI9h21; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 7DBBD100007;
	Thu, 14 Mar 2024 23:19:16 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7DBBD100007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710447556;
	bh=dZdE+su+h5MKSFhh1dYfaXULWdu4MR7WBdUhtZlwabo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=PxjI9h21h3MmvmkXg9Tb2oXLm7Dvga2806qCQnh5yXzhzC6DYKL0VhfLwyBFSIBP4
	 ErQB4eqSKKDHp7LH3vKwoofzmVEZfi8GFbV46ICdcqjchOKNZwVGB13NrjAeucqppe
	 bU007sG0T4Q/aiDEZ4JfGmq8onqQ7BMByu21EI/KTT4JWhybGCcJLQCxPfspUnrU7l
	 FjUEwEPjr4v5aN3pfNErdcoEKnNMFJAbNNmRA4JdyHeF80jkKhDIXGMylKhAXO5ySB
	 ZDNao1OF7NzWaduZ11Wfss5UB3PX0GdZjRhcSfDLGjWfmtr1JbN1oV5mWT5ipkuMfW
	 GZ/NUMzehjIjQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 14 Mar 2024 23:19:16 +0300 (MSK)
Received: from work.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Mar 2024 23:19:15 +0300
From: George Stark <gnstark@salutedevices.com>
To: <andy.shevchenko@gmail.com>, <pavel@ucw.cz>, <lee@kernel.org>,
	<vadimp@nvidia.com>, <christophe.leroy@csgroup.eu>, <hdegoede@redhat.com>,
	<mazziesaccount@gmail.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<will@kernel.org>, <longman@redhat.com>, <boqun.feng@gmail.com>,
	<nikitos.tr@gmail.com>, <marek.behun@nic.cz>, <kabel@kernel.org>
CC: <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>
Subject: [PATCH v7 0/8] devm_led_classdev_register() usage problem
Date: Thu, 14 Mar 2024 23:18:48 +0300
Message-ID: <20240314201856.1991899-1-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_uf_ne_domains}, {Tracking_urls_end_caps}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/02/29 16:52:00
X-KSMG-LinksScanning: Clean, bases: 2024/02/29 16:52:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped

This patch series fixes the problem of devm_led_classdev_register misusing.

The basic problem is described in [1]. Shortly when devm_led_classdev_register()
is used then led_classdev_unregister() called after driver's remove() callback.
led_classdev_unregister() calls driver's brightness_set callback and that callback
may use resources which were destroyed already in driver's remove().

After discussion with maintainers [2] [3] we decided:
1) don't touch led subsystem core code and don't remove led_set_brightness() from it
but fix drivers
2) don't use devm_led_classdev_unregister

So the solution is to use devm wrappers for all resources
driver's brightness_set() depends on. And introduce dedicated devm wrapper
for mutex as it's often used resource.

[1] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b@salutedevices.com/T/
[2] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b@salutedevices.com/T/#mc132b9b350fa51931b4fcfe14705d9f06e91421f
[3] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b@salutedevices.com/T/#mdbf572a85c33f869a553caf986b6228bb65c8383

Changelog:
v1->v2:
	revise patch series completely

v2->v3:
locking: add define if mutex_destroy() is not an empty function
	new patch, discussed here [8]

devm-helpers: introduce devm_mutex_init
	previous version [4]
	- revise code based on mutex_destroy define
	- update commit message
	- update devm_mutex_init()'s description

leds: aw2013: unlock mutex before destroying it
	previous version [5]
	- make this patch first in the series
	- add tags Fixes and RvB by Andy

leds: aw2013: use devm API to cleanup module's resources
	previous version [6]
	- make aw2013_chip_disable_action()'s body one line
	- don't shadow devm_mutex_init() return code

leds: aw200xx: use devm API to cleanup module's resources
	previous version [7]
	- make aw200xx_*_action()'s bodies one line
	- don't shadow devm_mutex_init() return code

leds: lm3532: use devm API to cleanup module's resources
leds: nic78bx: use devm API to cleanup module's resources
leds: mlxreg: use devm_mutex_init for mutex initialization
leds: an30259a: use devm_mutext_init for mutext initialization
leds: powernv: add LED_RETAIN_AT_SHUTDOWN flag for leds
	- those patches were planned but not sent in the series #2 due to mail server
	problem on my side. I revised them according to the comments.

v3->v4:
locking: introduce devm_mutex_init
	new patch
	- move devm_mutex_init implementation completely from devm-helpers.h to mutex.h

locking: add define if mutex_destroy() is not an empty function
	drop the patch [9]

devm-helpers: introduce devm_mutex_init
	drop the patch [10]

leds: aw2013: use devm API to cleanup module's resources
	- add tag Tested-by: Nikita Travkin <nikita@trvn.ru>

v4->v5:
leds: aw2013: unlock mutex before destroying it
	merged separately and removed from the series

locking/mutex: move mutex_destroy() definition lower
	introduce optional refactoring patch

locking/mutex: introduce devm_mutex_init
	leave only one devm_mutex_init definition
	add tag Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

leds* patches
	remove #include <linux/devm-helpers.h> due to devm_mutex_init() in mutex.h now

v5->v6:
locking/mutex: move mutex_destroy() definition lower [11]
	drop the patch due to devm_mutex_init block is big enough to be declared standalone.

locking/mutex: introduce devm_mutex_init
	redesign devm_mutex_init function to macro to keep lockdep feature working
	use typeof to redeclare mutex var in macro body (thanks to checkpatch)
	previous version [12]

v6->v7:
locking/mutex: introduce devm_mutex_init
	fix comment at __devm_mutex_init
	move #include <linux/device.h> upper
	commit message: change devm_mutex_init -> devm_mutex_init(), add point in the end
	fix and move up tag Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
	add tags (in the order received):
	Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
	Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
	Reviewed-by: Marek Behún <kabel@kernel.org>
	Acked-by: Waiman Long <longman@redhat.com>

leds: powernv: use LED_RETAIN_AT_SHUTDOWN flag for leds
	remove the patch from this series to send it separately

leds: mlxreg: use devm_mutex_init() for mutex initialization
leds: an30259a: use devm_mutex_init() for mutex initialization
	commit message: change devm_mutex_init -> devm_mutex_init()
	add tag Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

leds: aw2013: use devm API to cleanup module's resources
leds: aw200xx: use devm API to cleanup module's resources
leds: lp3952: use devm API to cleanup module's resources
leds: lm3532: use devm API to cleanup module's resources
leds: nic78bx: use devm API to cleanup module's resources
	add tag Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

[4] https://lore.kernel.org/lkml/20231204180603.470421-1-gnstark@salutedevices.com/T/#mf500af0eda2a9ffc95594607dbe4cb64f2e3c9a8
[5] https://lore.kernel.org/lkml/20231204180603.470421-1-gnstark@salutedevices.com/T/#mc92df4fb4f7d4187fb01cc1144acfa5fb5230dd2
[6] https://lore.kernel.org/lkml/20231204180603.470421-1-gnstark@salutedevices.com/T/#m300df89710c43cc2ab598baa16c68dd0a0d7d681
[7] https://lore.kernel.org/lkml/20231204180603.470421-1-gnstark@salutedevices.com/T/#m8e5c65e0c6b137c91fa00bb9320ad581164d1d0b
[8] https://lore.kernel.org/lkml/377e4437-7051-4d88-ae68-1460bcd692e1@redhat.com/T/#m5f84a4a2f387d49678783e652b9e658e02c27450
[9] https://lore.kernel.org/lkml/20231213223020.2713164-1-gnstark@salutedevices.com/T/#m19ad1fc04c560012c1e27418e3156d0c9306dd84
[10] https://lore.kernel.org/lkml/20231213223020.2713164-1-gnstark@salutedevices.com/T/#m63126025f5d1bdcef69bcad50f2e58274d42e2d
[11] https://lore.kernel.org/lkml/20240307024034.1548605-2-gnstark@salutedevices.com/
[12] https://lore.kernel.org/lkml/20240307024034.1548605-3-gnstark@salutedevices.com/

George Stark (8):
  locking/mutex: introduce devm_mutex_init()
  leds: aw2013: use devm API to cleanup module's resources
  leds: aw200xx: use devm API to cleanup module's resources
  leds: lp3952: use devm API to cleanup module's resources
  leds: lm3532: use devm API to cleanup module's resources
  leds: nic78bx: use devm API to cleanup module's resources
  leds: mlxreg: use devm_mutex_init() for mutex initialization
  leds: an30259a: use devm_mutex_init() for mutex initialization

 drivers/leds/leds-an30259a.c | 14 ++++----------
 drivers/leds/leds-aw200xx.c  | 32 +++++++++++++++++++++-----------
 drivers/leds/leds-aw2013.c   | 25 +++++++++++++------------
 drivers/leds/leds-lm3532.c   | 29 +++++++++++++++++------------
 drivers/leds/leds-lp3952.c   | 21 +++++++++++----------
 drivers/leds/leds-mlxreg.c   | 14 +++++---------
 drivers/leds/leds-nic78bx.c  | 23 +++++++++++++----------
 include/linux/mutex.h        | 27 +++++++++++++++++++++++++++
 kernel/locking/mutex-debug.c | 11 +++++++++++
 9 files changed, 122 insertions(+), 74 deletions(-)

--
2.25.1


