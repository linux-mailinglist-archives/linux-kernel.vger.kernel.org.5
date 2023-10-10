Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA077C0312
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343525AbjJJRzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbjJJRzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:55:35 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C666EB6;
        Tue, 10 Oct 2023 10:55:30 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39AHtQLc020714;
        Tue, 10 Oct 2023 12:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696960526;
        bh=2vRqxyjvNiTXuW5n7S+93rlxonDxAUlJF8y4TRgu2H0=;
        h=From:To:CC:Subject:Date;
        b=nyG7/iCR78SO1fVuZX55auCdF9WShnvuut1+0LqrwOj5RqhfbLRWnJFTLYuihRnZq
         LG4sk3hApC9mSaUB3ofUz0GFaQqorImtDnxWwG+EwIJp6l45eONONLVXUhLgvkZkKA
         lK7TecII96UCL8iLelYrIdkE+Wi8GBHMtWX1X3Z0=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39AHtQlu092611
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Oct 2023 12:55:26 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Oct 2023 12:55:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Oct 2023 12:55:26 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39AHtQWp035430;
        Tue, 10 Oct 2023 12:55:26 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
        ARM Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH 0/2] cpufreq: ti-cpufreq: Enable AM62P5 CPUFreq
Date:   Tue, 10 Oct 2023 12:55:25 -0500
Message-ID: <20231010175524.558577-4-bb@ti.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=655; i=bb@ti.com; h=from:subject; bh=3kH20oH9+v+qks6XbMW/ipJmFMODHCgjuRduTChPqIE=; b=owNCWmg5MUFZJlNZpX6GxwAAan///7/7+/v++e/j4/tNv25fHZU32H/K6Vev+utu+n7l7v+wA RsbRD1BoMQA0000aaGgADTI0DI0BkAMgBoDTI0A0yaMIyaNBoA08oANA0eoeo2mkOTagAZBoBo0 DQAGgHoT1HqDQABpoGg0ZPU0B6nqDTJ6ho0A00ADRp6IGgHqHqGhD1GZTT1AyaGJoGIAGTT1GIy AZNAyaAAYgAyBoAAAGmQNBoYjBPSAZAAaNLB9qUK/aAj4AgYj1k137AI4HRbTmhAw5B6wGgHrlh k0gTs+WUzZNyAsEstTkqwgDcswb+4YiOgC8sy4+x5lUWMSLN5EGSpwAuxFX760ld1JF9Qkb4xTU 8hUmjBTvgIlfdHJ7PXZk+c/6+m7DUkfl8s4La/DZNpi6AZxopK1mA7Q92oRhGQINUso7RbxIGSr JXJRTmIGSQ6fj5q5uyAbTL/4hsQOjEdmrGtcKI10MfFyKhaQGl4d2TuFjwjatkgd5kddMGKG6ej p8VFndHeFzyXoxZgpSrjsp9mJA9f1MtBuz/xg8VRQ1xn7UCOrZvSMXmdlZ8WjnvYV1I7uR+CBHn cHdB15qjrXgBwXHFA10rjum8r5vsP4CH8AArea+xBhFAgTvCmRzkS7I0J4++HqgZZ/OWceM6SAP 6rbGYMrqYd72b/i7kinChIUr9DY4A==
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone!

This short series adds the am62p5 compatible to ti-cpufreq and
cpufreq-dt-platdev for the new am62p family of TI SoCs. It uses the same
A53s and efuse configuration as the rest of the am62xxx extended family
so we're just using the same am625 data structure for the am62p5.

Thanks for reviewing
~Bryan

Bryan Brattlof (2):
  cpufreq: dt-platdev: add am62p5 to blocklist
  cpufreq: ti-cpufreq: Add opp support for am62p5 SoCs

 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 drivers/cpufreq/ti-cpufreq.c         | 1 +
 2 files changed, 2 insertions(+)


base-commit: c9727271cb239dce91add464364f10fb2b376456
-- 
2.42.0

