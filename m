Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26217E7793
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345758AbjKJCef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345753AbjKJCed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:34:33 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FE54680;
        Thu,  9 Nov 2023 18:34:31 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9NnoHN032079;
        Thu, 9 Nov 2023 18:34:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=Tmm3zP/7OqWuB7QWZOvKYzPAibLhWQ7ImYDN5ECfQu8=;
 b=hmshy5Jt5c5kmLGqiS6xHAanVPy2qFEEkr+qmvbU0YAWoXqXaL7rV55d/rM42FlyfUkr
 qKHmUj/9/xzVmjsn+kJW7+co5uUijRAGv91YUdQuuvONDboLsKrrWulp5rkjo3mVMlN/
 xJZtoZ7OuyGiKh0UJnMiLUCtVJDYOJoUYRyRXQ0+9QrbzRNJlg3faZ6YARgVLZXYqA8B
 EqvVxk5R9MpgP8o7Z5V//9B30KvuRDF4UWHRryNLQJ3QJ875bcVkwkLWCqSrMT7+zODy
 ldRGrT5AXZe5igHCKWGDTr9/UvbYqFDz+dvMuPJGdB0WycUOpshNrpSjtC11ZCawbcIS 7w== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3u7w1pwue0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 18:34:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1699583667; bh=Tmm3zP/7OqWuB7QWZOvKYzPAibLhWQ7ImYDN5ECfQu8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=TXRGg/xNYSpsG1ra/lR1LNFRwUDgPVwbhubvN8pFv+LgJM/EjNbltpaUanuCrwif9
         UZgM+j5Pd5YDTlfsEQMJawRpWdkK6ybF9shqzgRNpVPiq42dYBr2V529AFgVCzmZCy
         /f9ArYgF45E/drjNdI409oYm8JsVPPd6GHkEd+2iRpA3/VZko14D2uJjr2Dvpif8yg
         8110DKBlkXXkpqtkn0jQ98HKKZIqZOibVoN3xzVPHxpOf4erJjJKoXNMyJWk0tGxof
         B+JEmTKiMPismPEnXMv/4rphBDExFLF76wtEm/qALf90yztQIOtSNyKNo659O0CKSm
         R3HlnZjagfWTw==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A309A40493;
        Fri, 10 Nov 2023 02:34:26 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7FBA5A00A3;
        Fri, 10 Nov 2023 02:34:26 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=FRLKppu8;
        dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2707040149;
        Fri, 10 Nov 2023 02:34:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQqVIN8T9caI6r/NWUU55gCBa0AR6ThMxqmsDoUcMHMNl9wtQmbFitGIYwk0VU0PTrXVwSj89Ny+hyMBgOSWTz86yDaEMFilShWnIhS7lWDoA0FyZLk5Mxl6pbObuebFXiw0ICnfSCtv16PuWV/cwDGlzbWrWvylbF6KNsaZLj+I0tRuh0zcHadI25ZyM+h679Fk8XMn8o2qn3O6QOawW7pM2rGb7bxG4jJIzplu1PC3al34Hzsx8QGV9xhuL6QxbKmFP2KKGP+pCq+F/EnKFnFk90jIkgoG2KzdpEczH8TZkXfIcKsni1OIdoMVVjnvrdd46uDXzI5uE69eYE1sBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tmm3zP/7OqWuB7QWZOvKYzPAibLhWQ7ImYDN5ECfQu8=;
 b=J5yRiWC5KAb3ajfuKVWY3I2l361bHy0b3N3rYImOxj3PopL+REtTgg4wGgn6WSmIa/odOxQ9Hdm5D3IERiTugcdzm+HKcL3w+gwF1N4xp4X21ICag4RGk7YBz+3FcYK0vpE/FQhfM9cCSWD57nZIokgTj/GBuvVd7NZG5qGLv9pCDN4QsuklAq9+GD0rspYzjsqZaNvCy1IujX8Smln1Z6ObxNDtGx6G1R4gRUZVmueo4J0ON4EXxNJgqrfk09BGYMlQNOhQhECn5jUIIsuy3/WIf/Yo4K8ftwTqHbx6IQvm0taCfh2uuOZeySs9TL4W4imTi6aNreyeNDlP+8mN9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tmm3zP/7OqWuB7QWZOvKYzPAibLhWQ7ImYDN5ECfQu8=;
 b=FRLKppu8iDsopuCkoUi5wYOEKlUo50NQeed92W4uUpnqfIwRss6r+YZNWHw/Dzz0ogZVaTFssWClC995x9QnUO6EuBJ0vQvY22WxX7nCzbY+ZN0nqPlpK/bGhbJtnefx8XfPbKHko9BTWDRBPXzfrD2bWnB0M4MBfRVl22yqGos=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA1PR12MB9001.namprd12.prod.outlook.com (2603:10b6:806:387::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 02:34:23 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 02:34:22 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Stanley Chang <stanley_chang@realtek.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] usb: dwc3: add device put function to decrement the
 ref-counted reference
Thread-Topic: [PATCH v1] usb: dwc3: add device put function to decrement the
 ref-counted reference
Thread-Index: AQHaEVqfOsZnbsCb+0qG6kmJvmW9p7By2hqA
Date:   Fri, 10 Nov 2023 02:34:22 +0000
Message-ID: <20231110023419.nds42y4nmevpk75b@synopsys.com>
References: <20231107091252.11783-1-stanley_chang@realtek.com>
In-Reply-To: <20231107091252.11783-1-stanley_chang@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA1PR12MB9001:EE_
x-ms-office365-filtering-correlation-id: 60e0c866-d94c-4498-0143-08dbe1958c75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2zLxPy7x6Y411sL6REY88F4eOCwDXzJ9dudImd1na6QAs2WKFOsZEXJh6jCddTmV/4XZEUFPePnVsK/N+r6l911ckEcXGqTJbXT0eP/c8u+oJWkO6lnp3nb8zlczqe2lEN2K8EtVTuXTGd+uHrOyE+N0yw8yo6/wQ9CkUVx/Um3ZIPExGKEjeIQjsdgplEhaQVDdc3aU+YGcWVHcnF+gU8+eoBnNoUHeTTebugnwDhXMrd2zS6jIezflge8HxN2f8q8MZPRiA4LYU8i+2kgx65mor2ninZx5K77Z+lJehQsCmI3o5P/7C57tBxaUN2y2+UYRCSYmArYGn6a9qSTHMfYhYxV8UzEbqwvUlP4gR2MD2s7gtRU0leHkUYmjbQ8bZQzf+8uwYmZnegNpo0rUM0rVe3PV/5WSND7zNLFPU4N1pMYZEn7/pZWWQy1LIUC4LymBpkVddFYoN5a9nPP597vsjyoE7uEEyD7WcwV2C0fy1EHYuP9KqC13Nh/6hksQWUnw9tM3Q7EWmHgIZ0o9T3olNiorNAsR+7rGDHpRzMjpjmcSIls/ZMlDo0GXVPOnxuOZPxECpD77eMFFfViBp0FD/NwnNnhlByR9h0CPRvdz2YQpoIadjwIOq7j36VAW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(2616005)(41300700001)(6512007)(26005)(1076003)(6486002)(38100700002)(36756003)(6506007)(122000001)(66446008)(478600001)(86362001)(38070700009)(5660300002)(8676002)(8936002)(6916009)(66476007)(316002)(4326008)(71200400001)(64756008)(66946007)(76116006)(54906003)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dC9lSGNuNzBLRHFoYytSMkEvcjgrR2RxREJBdVV6YWtCNnkyYlFDelM4alhj?=
 =?utf-8?B?T3hLbU5COG1mREx0UFFyZGIxOEFlZ2RaWTVQUDVMM1hpNnVjV2NvVkxDa1k3?=
 =?utf-8?B?SGpDWmZFNk82a0w2YzlFTm5aVmFjRTlLbGtIaEJKY3ZHU1BneHVTYkM5Ukt0?=
 =?utf-8?B?K0RCR1NZSDV5NEFFSWptU1h6Q3J6OU9hSS9IMU1vOUV6NkEycG9ZWEtoNW1I?=
 =?utf-8?B?YnVnSXU5d1g3QkVnMlRza2IrbG8zeEJpV21VejdaQnFSUGptUWZXcVdBK2xp?=
 =?utf-8?B?ZmE4eXh6RGs2alFHd3YydlUyeWZDYmZZQXpueW10S05jN1RxYW9laDVIUUJs?=
 =?utf-8?B?UmdIT3lMM2NRVkRMTHE4SUNHWnM4N3U5UWNxZ2dRYVdVSzdNWkszNENST0NJ?=
 =?utf-8?B?bkRtVldrOExnMnRQSHBMeVBvbGwvVTdiZHBCczRSeHpETUdoK3daNUNlS3lM?=
 =?utf-8?B?MEZEaENXZ21FSFBsTGwrRkYwMUF5eW1KUzQ3TndRek40a1UvS3VOOGV4VWF5?=
 =?utf-8?B?aWxsQzZ3ZHowSnlSaTNsZ09nVzhJRUliTDlxLy9MRlJkSnpOcEhYMzA2NXMx?=
 =?utf-8?B?djcrQ3N3T2hBMGRmL2xFaHhpN3VrVFhNcTdCc3dVWjR5VGI2aERrNytRcTA1?=
 =?utf-8?B?VXpOdHJWUXBRYlBTanJ5ckd1aG9Hb0VGQ0daeXBVeERrcjRpb1h6NFVjOURU?=
 =?utf-8?B?N08yaWFJRTdXQ21QVXZuVHhjaytjellqS1dmdFh6OFJZUC9PSmJMS0JabXFD?=
 =?utf-8?B?WVBjWElNVmtnOGhQVm0zQ3dmNEpHNFNOUisxcDl5QUZSanFkUi9GdGRhRm9C?=
 =?utf-8?B?QTdWRHRVRFNuSDRsSE84OHlqZnVucEVsYWpTaXEzcEw3cng4b3NkWVRyMWcv?=
 =?utf-8?B?OUxvTFgyWVd5Q1JENExsUkEvWmNrUHlkUlM3cGw4UjJGSitPcFN2SzlHM01F?=
 =?utf-8?B?d24zMHozSG95RGZFT1QrSlpmL0NiRVVFZXhaRWxDUXJnUjVwZkdXQkJoY245?=
 =?utf-8?B?ZW9WUkJ6K0REdmxWZmo4NW9nQVJ4NVNVTjNMZWRwbnVmeGpvS3BCMm50SUY2?=
 =?utf-8?B?UnlQcm00V3dKdmhOWVorbDBQMkVudmlraDFXZ1oxbjhIZTM3S1hpNWwxU0pC?=
 =?utf-8?B?ZHR1dXdTb0gzQWdNSXNpeU9tNlNBY3pVZENLUnlRcHZ2VStnWUNIZUlRMjBZ?=
 =?utf-8?B?RHFWdEhPcXZ6VWE5cUtVQ2xLR3ByUkViK0NWTWNJbDV1WnJNQkFLOHBRNk9Y?=
 =?utf-8?B?djBKTFFtdHNTWktFcXl5amZBeXFoVjV2eTZmeE9mVENqSGZ1N0lDQmJ5TXUv?=
 =?utf-8?B?NndUSjdEZWNCeGNkSklwVDNYVTZrUEg2YXJiN3EzZE1KUUtMdTJsNDNYZkpy?=
 =?utf-8?B?RGxraWswQm5Pcy92TnpYYlhkb2xRaS9NU2FGUTVWc01QUUJDRy9BdUV0UGxy?=
 =?utf-8?B?TXBrRGVOT29uSEVDcXVsY1o1MUlYRnc5aXJYVG41S1MvblJZZDlmZlJ4STRQ?=
 =?utf-8?B?a0djYU1CbVpQd1h1UXB5N1VEZER2emIwTjkrQmMxN3JYcHFyNFVCZjlJdWVH?=
 =?utf-8?B?S3FVMU9ZUzNWa0I3UkFMcngxRXk5YW5KL2x5QzM1ZGRrRVo2MFQyanVOYjQ2?=
 =?utf-8?B?b1VBbDBJdHY5Z3ZtaG1ZSmcxcWdya25tM2QyQ2dNd1N1Q2NsWW9qVHNhdTJ5?=
 =?utf-8?B?cWdaZ1JURnBxaDJTcWhLalR4TERZNDZONVFyNDFtRHo4R2Vnc2dlVXpCTmlo?=
 =?utf-8?B?dkdweXZSeUMraHF4RDBNcFlRUS9mMEFia2dLMHV5c2dlbllhVW1ZRk5UVjdY?=
 =?utf-8?B?N2hXQ013M1pHSGlSbzJjdjhGU0hscXRtVTgwY2paUU5NanJVV1FuWjI3RFIr?=
 =?utf-8?B?eHYydkh3ck52bElGYnFaTHFSa0t0RzVlZGQwL0pFdFZ0bU9hZXRXUmp3Uk1v?=
 =?utf-8?B?alBiUitRQzZvQWgxNUFFSHFwVUsvVFYwK0ZCTno0SGJpRW9wb2pMT0JXQXY5?=
 =?utf-8?B?OXk5dzhKSXpxYjlKSUEvdCtHcVIxUEEwZjR4RHJ2MnBkMmpTTHc2bEZPQm5V?=
 =?utf-8?B?Qk5FQTZLOG4yTFhKZGNzQ2dJdTdBV1NqR0xHa28rNUdvM3NUUWZxamZNUU8r?=
 =?utf-8?B?ZHZoUDlJYjlRWUZkVTFsbnlseThJYlFpZTdBNkowSWFqQThBNDNpdi8wanNV?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE8DC0DAC223234988DD9159F04D8359@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: a4MTXEa0L6HgWrmCLoRORn51nzZdzf+JNW6tEeOlB6j00etazyNJ9EUSVtwARCkYfXzCNkD9RahkUpW8iL5OS14slnVrGkRRBr8HvbqsnK0UQO0PYxyHAcUqpE0Z9n6mTzV5S1z0+M4DeIZe7G53b3VGSk4w6nrDsDCQLrqP2E+J2JrX3HObdvxuLpo3mSwzKddCryzULhzrQAJnW6LcS182V7lA3ztpB7MRBBQoWiUbMhnqoHomyfBTwt3I7tJ7Prnlw5Qaq/Oa3M12weluN8R87FDb5HMSoVbLELmtmE1xj087hauc11yqAdDfPeb1ZfbTWanUeDlWC//xs7OJL8vzjxdP0MCLjIzGhr/hoJ4IswMDZivPSY6IS3Xgsi4KZod7AdqB8ax9D7+8fkNb5+oEeYoDGhh0VftadkhFi8nMbYC+f46V71Ks47JABQFdkKRT0Tr9gCKQz9HNRUXJRY8mC2355MNh4T0G75T2yx3OlJEDDHneJQkFS28RaKO6Tjfl4mxHwdkEYk5c0X4iFh8sywHmXDEDBnj5Cg/QsQ3Wu+eGADXHAO47zgDoIykaGEVxiJpntvu1n4GcEr2S5qVKsbQSKLHKOlSUnA8/phC3dOZ9V0bVLACGyldqZl8u9+pYB8x0EF079V9favMOIqSa2PnPDtNi61WB4E2RmYad1eTKzLphew3IKWPe1DET8o+zIcOMilS7NhWpU8Vzv3rlxrtaWcas91CJdyQoNQv5mxgis2sVlwv2GztMvJycj8oKu1xsqhzDSGd3ExpwjR8hFJIXUKOyx6PTsa8gPCRzRkrcIOpRUdkSQFTSfpODadUD25ttSbqaAUOKn00OGq3Go6eBxtBM1TYYPDpq8BL5CzIjUrkNhsvXxr2K1tXl9FRndSD0LVdn8uxq4B8u/0DuA/sTeltNvP2DFREf4Ak=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e0c866-d94c-4498-0143-08dbe1958c75
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 02:34:22.5552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/31baThRK8t6W9Q/qneNPT7l0PZjh5UG55CkVIeL1qMTv+j0LKz1L/s7UcVcUBLdmFDhOWjSJnsNgkTCUR30A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9001
X-Proofpoint-ORIG-GUID: --L5Z0334gOhKB7inBTjQeyBwGJOwC6y
X-Proofpoint-GUID: --L5Z0334gOhKB7inBTjQeyBwGJOwC6y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_17,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=534 clxscore=1011 phishscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311100020
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBOb3YgMDcsIDIwMjMsIFN0YW5sZXkgQ2hhbmcgd3JvdGU6DQo+IFdoZW4gdGhlIGZ1
bmN0aW9uIGV4aXRzLCB0aGUgY291bnQgc2hvdWxkIGJlIGRlY3JlbWVudGVkIHZpYQ0KPiBwbGF0
Zm9ybV9kZXZpY2VfcHV0IGFuZCBvZl9ub2RlX3B1dC4NCj4gDQo+IEZpeGVzOiAzNGMyMDA0ODM1
NjkgKCJ1c2I6IGR3YzM6IGFkZCBSZWFsdGVrIERIQyBSVEQgU29DIGR3YzMgZ2x1ZSBsYXllciBk
cml2ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBTdGFubGV5IENoYW5nIDxzdGFubGV5X2NoYW5nQHJl
YWx0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZHdjMy1ydGsuYyB8IDMgKysr
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZHdjMy9kd2MzLXJ0ay5jIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLXJ0ay5j
DQo+IGluZGV4IDU5MDAyOGU4ZmRjYi4uOWQ2ZjJhOGJkNmNlIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3VzYi9kd2MzL2R3YzMtcnRrLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLXJ0
ay5jDQo+IEBAIC0xODcsNiArMTg3LDcgQEAgc3RhdGljIGVudW0gdXNiX2RldmljZV9zcGVlZCBf
X2dldF9kd2MzX21heGltdW1fc3BlZWQoc3RydWN0IGRldmljZV9ub2RlICpucCkNCj4gIA0KPiAg
CXJldCA9IG1hdGNoX3N0cmluZyhzcGVlZF9uYW1lcywgQVJSQVlfU0laRShzcGVlZF9uYW1lcyks
IG1heGltdW1fc3BlZWQpOw0KPiAgDQo+ICsJb2Zfbm9kZV9wdXQoZHdjM19ucCk7DQo+ICAJcmV0
dXJuIChyZXQgPCAwKSA/IFVTQl9TUEVFRF9VTktOT1dOIDogcmV0Ow0KPiAgfQ0KPiAgDQo+IEBA
IC0zMzksNiArMzQwLDggQEAgc3RhdGljIGludCBkd2MzX3J0a19wcm9iZV9kd2MzX2NvcmUoc3Ry
dWN0IGR3YzNfcnRrICpydGspDQo+ICANCj4gIAlzd2l0Y2hfdXNiMl9yb2xlKHJ0aywgcnRrLT5j
dXJfcm9sZSk7DQo+ICANCj4gKwlwbGF0Zm9ybV9kZXZpY2VfcHV0KGR3YzNfcGRldik7DQoNCkRv
bid0IHlvdSB1c2UgdGhpcyBhZnRlciBwcm9iZT8gV2h5IHB1dCBoZXJlIGFuZCBub3Qgb24gcmVt
b3ZlPw0KDQpCUiwNClRoaW5oDQoNCj4gKwlvZl9ub2RlX3B1dChkd2MzX25vZGUpOw0KPiAgCXJl
dHVybiAwOw0KPiAgDQo+ICBlcnJfcGRldl9wdXQ6DQo+IC0tIA0KPiAyLjM0LjENCj4g
