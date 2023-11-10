Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AD77E85E4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 23:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjKJWyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 17:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjKJWyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 17:54:15 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6589D1B3;
        Fri, 10 Nov 2023 14:54:12 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AALksIP030001;
        Fri, 10 Nov 2023 14:54:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=WlPgxeQctjtq5u9Jr1iheXWE+0F2A4DinIJphwRvw+I=;
 b=SqEkaT+dJtqsr3imx0S1fEd4hah8r+shT0pTGMmFZB4QMAw8VKP1L+3l8G504XdLqL3H
 bE46dT/CKBaie3eLQy494PBuTy0Q+ijfAgAjmHYM6ziX2LcB3DimXjPAcRJLZ2IuVYVg
 9lClk4XJApsCHa3peA+0ijKi9zII5beo5042wQWKVJ3qqMr0G2vOOW1awr3/6bLpiLAl
 FAEiyjadR/cXSiTdZp8UZ2X5qvHMm6ks45aOnHaNE+PmZzVsAwYQu3de4Qn6O+cawlqA
 WU97yxwusWuXG4DBWlbrNbtJPE7ZQlb5nVif/PyRYdGHa/6pLlvnhNb7lgsblLIlnVvT 5w== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3u7y3fj8jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 14:54:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1699656847; bh=WlPgxeQctjtq5u9Jr1iheXWE+0F2A4DinIJphwRvw+I=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=alibX9DCpcNRGNi3vY5/QNhV4vlYdYrSyykTElZarnSZzC8jgeVfx66JBAYzXeWYA
         25pg+U4oSk5xQyGa6ADAdgnQfFgECsoKj47aSe6v2JFdhnbt+6R1M7pTAdWYRtJftT
         bwLu2SbYQCvnlahKeX2dpZy7s4KfzlSTWe7aDAmC+lYGLUw45sqYVq130Ft6r5E2vA
         i+sRGxtLA+yQ2xYT7pZbPD+l6Jkck3JWbYBsLC/e71ynshMPu4L+TfT4dCTyag7jXh
         FW3SLdE+Zp3jCdSwaL6DHob5ixvxB59sOLgQZe3UbPSEBy02miqrQG5LlGBLkYKNtF
         wdUWLnba1wBcw==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9D05140087;
        Fri, 10 Nov 2023 22:54:06 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2EEBCA00B7;
        Fri, 10 Nov 2023 22:54:06 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=jvU0thZe;
        dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 543674029A;
        Fri, 10 Nov 2023 22:54:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0CREfOHunMWJhSuzEcTkuUfSa6/mOnk6YkTqXLV8EpUzNgXlv48LS54j15V4ytsneoHWrhkVVxsXdHS36IToV9yFO1kCqD+pSxOVoUpxxDeacJnMwHwSJTWTXI+wJv05xA0WZTdrjvhxRpqDK+1jdaGEYheOaY6HVI1JHfzqU+pRh7UywyM0Mmfr+onYj76wiEveRnP/IR6GksOxgmpnKpbi7/5obLKpotZAWg1pnLim0flYRpRa81ku58JGIQQU7ryG3jVrxl9sAbRPINM/MgvCxRQ+cGgMKmJdHRrWzhI/70kxtFNAqIuN2wWOIHtdkeyJu7NrvW/0oKj+fPPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlPgxeQctjtq5u9Jr1iheXWE+0F2A4DinIJphwRvw+I=;
 b=HTSikviJ1ckhYNbiQ0PlLMdKGvHAnkZXVt8EpwMVS91QiAPMJLf/muWBx4NtriXrULsY6TznLCZfdTXt7zCwmjeFkLBInq1o+gzCvaqCLIjr8l0tDotKc095tmt52jd6z+obT67f/gocIarPT2rezFefpT68xPtJ6qRc4bxQgAdxLty/zbuM9+N6yeFK30qpXyLWV1b6Yad51pAgpQchW/ReNbhDToTpep9DAG+UhMS2x3MCEZTW0z8FyKuT/DOHSUbYn/NF0o3/Vz0h6bKZHdFklgySrMdbj113qM3V4u7TXi+SOOAzSpQ5rs+bnh1m+PYnoOP85rTB4Atv9ETDxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlPgxeQctjtq5u9Jr1iheXWE+0F2A4DinIJphwRvw+I=;
 b=jvU0thZe+5kSUDtyQlO1aVx/n4RlyMgid/NzGjUW43l+TkupoQYRq0GNi6tZawmhBYME/LzJIIiBW91hdZn7RYQUXO42SvaKKh+JtUu69j6oYbH47eAoTMVdd2HJMVYZ6jskUsdeC4aUmjzOwUpotcRxt5g4k+fpVhDgY0psN2E=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BL1PR12MB5046.namprd12.prod.outlook.com (2603:10b6:208:313::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Fri, 10 Nov
 2023 22:54:01 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 22:54:01 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] usb: dwc3: add device put function to decrement the
 ref-counted reference
Thread-Topic: [PATCH v1] usb: dwc3: add device put function to decrement the
 ref-counted reference
Thread-Index: AQHaEVqfOsZnbsCb+0qG6kmJvmW9p7By2hqAgAACmgCAAVHhgA==
Date:   Fri, 10 Nov 2023 22:54:01 +0000
Message-ID: <20231110225257.q7yuelehavx73k5b@synopsys.com>
References: <20231107091252.11783-1-stanley_chang@realtek.com>
 <20231110023419.nds42y4nmevpk75b@synopsys.com>
 <4721829510e04b12bdb3c38f406b9584@realtek.com>
In-Reply-To: <4721829510e04b12bdb3c38f406b9584@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|BL1PR12MB5046:EE_
x-ms-office365-filtering-correlation-id: 3114b2c9-8565-435f-ff91-08dbe23fee4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +jI5/N+LwO6t23vH7SaudVMad/MwiarGgXYGRZWiEUw+qWAvCQAO3CU1sVrafs/vDwkjwjAt0ST2b+FPZzfdQ6+2brU2y79xizj/xAPV0JeLFQa3GqUjAodtZPSWctgQaiVBnCAMbUJ2+nASIkPF3QzIxNG+a3gSP3rAWhFNrLCTmm8aAvIiQXpdh0oZjZVsJ0ljIl/wTlywvir3o57w438YJY62DzaHQo7Z6345CoqpZx/jvdVMSAbb9FPwTndxsjBlgx2OgT8ZH7mVYhCXwsOpaKUCCqIMPy4cfET1uARQ4g2AvKVEYN/cyDEkjLLqbRPheRmoX7gqJNMiuZ5w6surbGcBJ1HK+qScgL1pKTTaOnjNuhOZeMKavFvs8sW63sE2WmelVBoTZuW702dgbuTgrSWB2WsDy/KiQ2J6jP+d+QsogaUfrbo5tHsiRIKdDu9ayDca3MNRXLUGUHvgygnB4geuZFnL/Iz5jJ4TD4k163LDBc2K7XkpmusohD/Gw6xWWIaBggW5EFrUJuneFJnRTsttRnK2qW25kjQtJ067VnC66HSXgP0su4tqROf8lhf4S1fsnURm0wdckxfF5H7ox4KFnYyaEFqDuMIApvUm3pXK3bfsx2OYMPqvvegyXDq0ABpX8aRTkyxqUKJlsnCDZYLUu1+3V27Wl6H4yAw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(230173577357003)(230273577357003)(64100799003)(186009)(1800799009)(451199024)(2906002)(41300700001)(478600001)(4326008)(66476007)(66946007)(6916009)(316002)(1076003)(38100700002)(36756003)(91956017)(8936002)(8676002)(64756008)(76116006)(66446008)(66556008)(6486002)(38070700009)(54906003)(5660300002)(86362001)(83380400001)(122000001)(6506007)(26005)(53546011)(2616005)(71200400001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmRFeFJDUzRRR3pRWUh2SVdUczIwVjMwMzlvU0ZMeFBOU0RaM1BDWlVhNnRS?=
 =?utf-8?B?UkEzRndmamc1amhRTmpaMU8yMVFRWHB5dmZub3JtRStSOEhwRVFFKzRhc05k?=
 =?utf-8?B?UGRVS0VOaithZHpzaFFHNVpzaFZEa3FQKzlYNHJhMFMxcFRiT0JnSjJXc2tI?=
 =?utf-8?B?UDhCR0xjWlUwRVd2RXJFWXkxZlNlaXgycDBPRlZ2VHVGVG9UNmt1dURnWTB4?=
 =?utf-8?B?SGVad0lWVng2V0hNV2RKNU9SZ3cwY3AvelJMM0QyMGhVQ09oaTZkd0hsTTdt?=
 =?utf-8?B?RVN4RHBKSVE5UXlBT0UxSEllOForNjNnZjJtVzdNaFdxa2E2UUtDemEzVmx2?=
 =?utf-8?B?ZEkrRndjVVZSZVV4RklRVTVldGs1UDlJZHBDNmZjcTBNMUlHOEdhYklGVmhZ?=
 =?utf-8?B?Q0IvL1hWZmphQS85SU5hTWE5QlY5em1lTzYzazIycW5wUllzRGRtUFlJQ1I1?=
 =?utf-8?B?L29JL2J0dzY0UVhOdkg3dGVRMkxRd0pKeDRhanJpd0QrYS8zb0NPMWIvQ0kv?=
 =?utf-8?B?anFiQXphVHBieUVUTVZvYzFyU01INzYxM2xYTzNDYmtUdVo1S1U0blVxalBQ?=
 =?utf-8?B?MDRwakJWSUY2bGJualM5MWM5ZmRIRVI3Y3RwbG42RjlsY1NaNVdCUGtYNG00?=
 =?utf-8?B?aHFia0FHK2hFNVcrZ0FDZFJhL0x4dlYxZWJ1QSsvclZQZTVUbFJBM2RWWkY2?=
 =?utf-8?B?UHpJanlPVm5hQ3hCOStwc2xhQ05USkRnNkFVVkZueFhvQllNdmVSWFVTay8z?=
 =?utf-8?B?bVZiNy9HRTh6b2p0NzNZdThncVdvc0QrUlFyZVFjdFo5aFZsV3p2SVNWVXho?=
 =?utf-8?B?ZVVFVVpyd2VQMUlnWGJtOXdzZGhLYkpZU0Y5Sm9wOGdjUWRYcFBTSytiNUx3?=
 =?utf-8?B?UFlWRlc0bDdzSy9EOVlyY3lKRWtpN1ByMUlYNWREYTFzUjdCenF2TUV2cDVM?=
 =?utf-8?B?TzFONmRsbEJDb0dSeEJSRDlETnJvUmxQTjE0V0NqTUlXTHYvd25FcUNxdlp6?=
 =?utf-8?B?dnlqK0VWdGVWVzJMNGdaanA4eXJza2VFZDc3M2E2RXdUMnJBdm5UOTBHNy9G?=
 =?utf-8?B?WEtjK2szR29jZDdtZVd4a1dVU3pLQmhLNHZ2Q3BTWjc1d0FqTjFvRjcwRThF?=
 =?utf-8?B?cE1RL2t4NnY5MVN0RDFIVzdlMEdDazJuM2JDYzJBbFJZeXI1T1VZM3JaSXlq?=
 =?utf-8?B?VzFwb2RMV1BEczlaR1VGTCtSeHJNL0xrd0o5N2o4RG8zNDZENEUxcTV4bnlv?=
 =?utf-8?B?TEFzUE81UFRkeDA4R0xRM0F1T0ppbzJSdS9tcFFVem82UUhnUDhvU0hnUGZm?=
 =?utf-8?B?ZVN0QStXVytCZ0pFMllITUVEVDcxVW5IWEhHUStzcUdPckV6QTBVVFZBNHJX?=
 =?utf-8?B?eVRrSU1FS3N3RlNlVTZEbWh1N04wQnNiTEl0b2dkOGJ5QlUvU21mN0VadGl1?=
 =?utf-8?B?SHRIVGd4N09VeHlaM1FNVVdsNjIxZGprL2c3YjR2THBLZm1qT2hkZTRjZ08v?=
 =?utf-8?B?T2RENS9FbzAyakx3TVIzQ1FmTmVDS2JQejJvelJmYnlxRFI2ZWdndk4wZGdB?=
 =?utf-8?B?Uk10NVpHNzFtSHNUU05LeU9XREc5SS9LQnhtM3FUZkhIUkRNSm45VWRLYVVM?=
 =?utf-8?B?cktmU0dpSnlabzB5alpPNWI1VEltdll2Yk5iYUFzMHZ6MkhubGdTTXVwNkRW?=
 =?utf-8?B?Q09tZHQxb0JKSGprcktDM2xyck5CdHFNc0RWRTZKOVpKcWVXS1NCd0grTHdO?=
 =?utf-8?B?STFod0J2L0x5WG5qUkJISjVJcXlxQkVRa1ZsdkNGN21OTlBlTmpmQlY3OGZp?=
 =?utf-8?B?eUp0amxhUXhoeDBnQ01wR1hPdEIzY3loTWpnMzQwRU1oUlgzRnNFb1V1aWtm?=
 =?utf-8?B?L3R6NmQvcElsUW5aRjd4U2VxcitDM1VrbHBWOUVmZ2lBaWJENU9wZXBSc2px?=
 =?utf-8?B?SVhURnZEeTB1cXBEdGVqeWhzYjkrOEJ5WS8raHh3Nm1LbHFISmdSZ0NmMjlm?=
 =?utf-8?B?bEUrTXhHNmY2NVhlS2pwcFN5R2dsbkF3SFI1a2JtVGEyNTRCK1lTck9aUFph?=
 =?utf-8?B?NTk2dDF3UzN4QUdjQkk2MXpjem5TdWxyZGVmRFNjcWdQUGYxd1I5NFZvMGt1?=
 =?utf-8?B?KzNIcFRqbGF5WldPZUtGcnc2R1VBRUFZREtiT3lodHVUdWptcE0yMm9Tc1J5?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9DDDA342571DD4C83387F485D2C6913@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: W0H9e69xIwXUIv2fyZgyPJL352iPnlK0ttXv8/CUXItqRU5aXYkLyOefK/8W/PeYTV0HSPMh4+QlUQfsSuUiPsAoZPjOzlZWLD+ow0K79bg0S8gTbo5zMo/I7/KXzCqDZ0iQ8ydsgehG++lKIL6CqvIrKvz+Itzb/BdVofFyDj5GU0eRGLT3hKHTuMN+0WFLRU6t+YGR/kwBrywZ7QE1z+Z2AewkyqTHjKryB79qsQaOIixb+nlAW+/LBw3IhEqrcUD+AzFYiet3lne0i620d9ym/2RXWv52ogDt9ePGQ0t5aOZ+Bsf40m8QPsBfB7J++IXHzS4Ufe9ucWnOid3EdPHbToSkysIPdNSyBgx2YQaSIYv2ODXmfFofEqXA0H04lZkgXKKMD26s0rDHrCl2YNMUhY9W21xf7NZSL4SDBPLOMU3YXh/2AHm52rfkVJZA1mtcewM8KqWfaGRxn2WUACUjjlTbNWV3TXVe+ueBs9ZjgnVUDRWmUOW+nQk251zAr8WW3j9X4HjZUzwhdaWi+UT8oRq2NVmVjya64G+sOX95OIsxMYE/FJrqB5QX4Wrg81QhlCIhi2GTRceKA28CcV6HYY7DxQtxcDOhaNTyfhqeMHn2MbYAjOIEZMjhB7UOwrMKyruxhYbWqjht6CI43SUitbb/M7eTwOnLFxK8vIde/c7H7wvt5oO0SkTgsq6RZacdXZoULe/whOLAgumAgxEI4TboM3C79hwotxXe61VdBWHX5ooLTzQqqBKMQtpEwZU/goIiYFWc6RHC6qbDTen9QONPv02zS0ghf6kgGK8tzLwp++hiCVmzEnYayau09BNRsUd9tv1uF+ao5HDvpA9sMCplYgsP/m9hvP16dHI3ixpvY2QdXgl8vGkZetVs1zujhsxMn7ty/WB61jvLRt7d7Pm6YeOL6a49z53+um4=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3114b2c9-8565-435f-ff91-08dbe23fee4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 22:54:01.1889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cr3/Wn6XMNFR0v05TBERUda5TFRWkhcT5Tn8x6NJWWrgHT21qUvdZFGxu7E+5WgMwgA2HR+KkF8Rpr7U0g+lsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5046
X-Proofpoint-GUID: z4x_euZafstuJz9WMKvmtNYK_Dyf8C8w
X-Proofpoint-ORIG-GUID: z4x_euZafstuJz9WMKvmtNYK_Dyf8C8w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_21,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=728
 phishscore=0 suspectscore=0 impostorscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311100190
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBOb3YgMTAsIDIwMjMsIFN0YW5sZXkgQ2hhbmdb5piM6IKy5b63XSB3cm90ZToNCj4g
DQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogVGhpbmggTmd1
eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiA+IFNlbnQ6IEZyaWRheSwgTm92ZW1i
ZXIgMTAsIDIwMjMgMTA6MzQgQU0NCj4gPiBUbzogU3RhbmxleSBDaGFuZ1vmmIzogrLlvrddIDxz
dGFubGV5X2NoYW5nQHJlYWx0ZWsuY29tPg0KPiA+IENjOiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5n
dXllbkBzeW5vcHN5cy5jb20+OyBDaHJpc3RvcGhlIEpBSUxMRVQNCj4gPiA8Y2hyaXN0b3BoZS5q
YWlsbGV0QHdhbmFkb28uZnI+OyBHcmVnIEtyb2FoLUhhcnRtYW4NCj4gPiA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+OyBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOw0KPiA+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSB1c2I6IGR3
YzM6IGFkZCBkZXZpY2UgcHV0IGZ1bmN0aW9uIHRvIGRlY3JlbWVudCB0aGUNCj4gPiByZWYtY291
bnRlZCByZWZlcmVuY2UNCj4gPiANCj4gPiANCj4gPiBFeHRlcm5hbCBtYWlsLg0KPiA+IA0KPiA+
IA0KPiA+IA0KPiA+IE9uIFR1ZSwgTm92IDA3LCAyMDIzLCBTdGFubGV5IENoYW5nIHdyb3RlOg0K
PiA+ID4gV2hlbiB0aGUgZnVuY3Rpb24gZXhpdHMsIHRoZSBjb3VudCBzaG91bGQgYmUgZGVjcmVt
ZW50ZWQgdmlhDQo+ID4gPiBwbGF0Zm9ybV9kZXZpY2VfcHV0IGFuZCBvZl9ub2RlX3B1dC4NCj4g
PiA+DQo+ID4gPiBGaXhlczogMzRjMjAwNDgzNTY5ICgidXNiOiBkd2MzOiBhZGQgUmVhbHRlayBE
SEMgUlREIFNvQyBkd2MzIGdsdWUNCj4gPiA+IGxheWVyIGRyaXZlciIpDQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBTdGFubGV5IENoYW5nIDxzdGFubGV5X2NoYW5nQHJlYWx0ZWsuY29tPg0KPiA+ID4g
LS0tDQo+ID4gPiAgZHJpdmVycy91c2IvZHdjMy9kd2MzLXJ0ay5jIHwgMyArKysNCj4gPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1ydGsuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1ydGsu
Yw0KPiA+ID4gaW5kZXggNTkwMDI4ZThmZGNiLi45ZDZmMmE4YmQ2Y2UgMTAwNjQ0DQo+ID4gPiAt
LS0gYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtcnRrLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvdXNi
L2R3YzMvZHdjMy1ydGsuYw0KPiA+ID4gQEAgLTE4Nyw2ICsxODcsNyBAQCBzdGF0aWMgZW51bSB1
c2JfZGV2aWNlX3NwZWVkDQo+ID4gPiBfX2dldF9kd2MzX21heGltdW1fc3BlZWQoc3RydWN0IGRl
dmljZV9ub2RlICpucCkNCj4gPiA+DQo+ID4gPiAgICAgICByZXQgPSBtYXRjaF9zdHJpbmcoc3Bl
ZWRfbmFtZXMsIEFSUkFZX1NJWkUoc3BlZWRfbmFtZXMpLA0KPiA+ID4gbWF4aW11bV9zcGVlZCk7
DQo+ID4gPg0KPiA+ID4gKyAgICAgb2Zfbm9kZV9wdXQoZHdjM19ucCk7DQo+ID4gPiAgICAgICBy
ZXR1cm4gKHJldCA8IDApID8gVVNCX1NQRUVEX1VOS05PV04gOiByZXQ7ICB9DQo+ID4gPg0KPiA+
ID4gQEAgLTMzOSw2ICszNDAsOCBAQCBzdGF0aWMgaW50IGR3YzNfcnRrX3Byb2JlX2R3YzNfY29y
ZShzdHJ1Y3QNCj4gPiA+IGR3YzNfcnRrICpydGspDQo+ID4gPg0KPiA+ID4gICAgICAgc3dpdGNo
X3VzYjJfcm9sZShydGssIHJ0ay0+Y3VyX3JvbGUpOw0KPiA+ID4NCj4gPiA+ICsgICAgIHBsYXRm
b3JtX2RldmljZV9wdXQoZHdjM19wZGV2KTsNCj4gPiANCj4gPiBEb24ndCB5b3UgdXNlIHRoaXMg
YWZ0ZXIgcHJvYmU/IFdoeSBwdXQgaGVyZSBhbmQgbm90IG9uIHJlbW92ZT8NCj4gDQo+IEkgZG9u
J3QgdXNlIGR3YzNfcGRldiBpbiBkcml2ZXIuDQo+IEkgdXNlIHJ0ay0+ZHdjIGFuZCBkd2MgaXMg
cmVtb3ZlZCBieSBvZl9wbGF0Zm9ybV9kZXBvcHVsYXRlIG9uIHJlbW92ZS4NCj4gU28gSSB0aGlu
ayBJIGRvbid0IG5lZWQgdG8ga2VlcCB0aGUgY291bnQgb2YgZHdjM19wZGV2Lg0KPiANCg0KVGhh
bmtzIGZvciB0aGUgY2xhcmlmaWNhdGlvbi4NCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhp
bmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KQlIsDQpUaGluaA==
