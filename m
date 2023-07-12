Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794D5751411
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjGLXDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjGLXCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:02:21 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19BF173F;
        Wed, 12 Jul 2023 16:02:17 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CKZ4ul015545;
        Wed, 12 Jul 2023 16:02:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=/hQp/2BYD8kzVAmyOuAESwnVIe1BMx8kSU48yniN9QE=;
 b=FpSvrsYyPyhAQa266ZS2kjerr6j1i9NfODwLHuwd0UZrqREuYjecGUneMcgxzeOwtLbs
 eKfyrwsFasTj+1vYVBs9hfj8Oqz4M42tHc/2RVpZxhjq5cXIbvZMyxACeEPGSN8q/R3O
 pDT4q3hqFyVwqlP3IQjY77XjEe5P8M0EA3Fhrmar0bEurpjrLS7ZwC8H/anIYyBOgj78
 GuBj9vcSAR8dQRAug2pq4FRlCeRjemDFAYnd4y7PxKXNaqp4QJbNgmssytL69KDr+zEu
 obMjgpSHOrqUEY9VKsbm6x7secU8CgKtVgRl+X1wO275MHGeN7ryhCnH+SIKA6s7V5me 1g== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3rq6ef57xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 16:02:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1689202932; bh=/hQp/2BYD8kzVAmyOuAESwnVIe1BMx8kSU48yniN9QE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=iqiOpiektUUt5g9HbOys0um7zd1+rxtkX8oS8aodPExvwEwx6myv4v/Zjs3TJRzeQ
         fXct5jFH8TxtW1l6gkScT4sZrcbawIC37jbRiY9HROGE4bAN6StmlNJn3qOkJIzvaT
         Vv+FlE6QDJzaKaY5x5lqpDrwvycItwhAgQ38ityZUpE+a+Lpe4gEmH3g6yHOxgfv5m
         wU8yGoEiOmppGWcjW5Q5CiNaolf6yH2GbuafBX0GiUIzaNX5p8d/LXtxRkZyep8AWH
         CsR7UoKHRFPC56t2A5V/dLqebxKZEo+27NxqWyVDKr74G0kDivajlykM2UJrTzXumA
         2iddMm4x3/jnw==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1A5934013F;
        Wed, 12 Jul 2023 23:02:12 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id B7818A00EA;
        Wed, 12 Jul 2023 23:02:11 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=eCzS9e/E;
        dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2FDE140136;
        Wed, 12 Jul 2023 23:02:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bC8LkpXE6Kc4bD4bRfF14ua0epyXCyq5YCHdPRJkpHmeP641bXY/6w075RpnjejWSBjHxgtdsUTVN7jF4QgO8lYkU4ck0rIvDCKG2+Y8URo24zPRWVmBGJYbIZJDKiepXRTsbTimjzVLStXdsVLa8Lb1U6Dt8iPNOUq0J+pPJGp3jdeXS5ovT4bBEz+tCifMsXWS2wIZ13+KE0Yrfdr8g7w4g/S+eT+/ej/+W+cKw7Cz7r6cBz142YSA1uY+jbjyM0KFiEQEKON/hPz92AD98f2MaJNSovdJzaz+O65a4jin1dz800g1DqY7DBVnUFLAXfFuaIZmQmbkVrTgSATUog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hQp/2BYD8kzVAmyOuAESwnVIe1BMx8kSU48yniN9QE=;
 b=D0ynI+9+x2iT71sndf7HdYQ+ApWls15ENuc68nwLMeSglinIM8tamrJhWKgTqPcYaxWzBPVmi0PifqNpZ0CaytjSPW9CYtY6jvsBxdm1K9dFY90DGufZb1r8kg5JNGnwyDWtlBXUCIjtHbLmvO8fqZbVqBNtmPxBEwVsOfvmYFEfH4P0gpt9AuCp8J6y7WUMzc+5D4+S0z3FZKlsv8cbrvnyWMLk1pQRYo1f8utg+EikrftgJlylW3kgECFrXReOlx0PsumVbueqVfJQEcGyQDv1NRmGo1XGsj3anx+e7vUlrBv3FJG8j7QMocDqM54WZZKNVKmoPDVoLB6KyOGmWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hQp/2BYD8kzVAmyOuAESwnVIe1BMx8kSU48yniN9QE=;
 b=eCzS9e/Exfm9lVWCAAkwN20eWqslkf6LoEXXVB6ZKs/RIhQwzkPalKrmqX7Nejm+rG1xFMv0QbBjyj4SNcMO+QQUujALQZxx61a4Hsb0fWv9vQuhY5kdf2J+rXWLomHioOL+XphY05synQLaQbi/1eiO2R0h+I5qLFf39W0p+RA=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SJ0PR12MB5504.namprd12.prod.outlook.com (2603:10b6:a03:3ad::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 12 Jul
 2023 23:02:08 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::adba:1075:fd90:fe1d]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::adba:1075:fd90:fe1d%3]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 23:02:08 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     =?utf-8?B?SmFrdWIgVmFuxJtr?= <linuxtardis@gmail.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Mauro Ribeiro <mauro.ribeiro@hardkernel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] usb: dwc3: Disable AutoRetry controller feature for
 dwc_usb3 v2.00a
Thread-Topic: [PATCH] usb: dwc3: Disable AutoRetry controller feature for
 dwc_usb3 v2.00a
Thread-Index: AQHZq6N8Rx/zK10gr0O1P8J0n8tAsq+rzjEAgAEZboCACEP7AIABo/eAgAAC5wA=
Date:   Wed, 12 Jul 2023 23:02:08 +0000
Message-ID: <20230712230204.j7g63skeitpdvsom@synopsys.com>
References: <20230630223638.2250-1-linuxtardis@gmail.com>
 <20230705224754.zmffebz2geg3bclh@synopsys.com>
 <d4576e776d49498dcc1f82ddf2b81b415e0c6e4b.camel@gmail.com>
 <20230711214834.kyr6ulync32d4ktk@synopsys.com>
 <4246badbbe4c106f965cc8758849390effc48c36.camel@gmail.com>
In-Reply-To: <4246badbbe4c106f965cc8758849390effc48c36.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SJ0PR12MB5504:EE_
x-ms-office365-filtering-correlation-id: aa3cae4b-6264-4a36-ef66-08db832c04d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PVu7Lz1ggPpmZCi9nSWB8byJaWPpX6VOb/RYQIxFAnlKuxN6ELDMIPINEJjAE+m9wNESUhYwlCQeimZLUiZRnsE+RhXrL3Ojf6xVyXn3fuE5/SxRcZ+zvyFHYBuYxJlZBCqeDsFz9MBcyBsGX/AG18h+w8RifG+MuuxY4C6dToLFiyrL0gvj+gkuqVpnbM4BOfK9uwYMANuocfLnWc72rhrn/m4+ZmeG/zSaHt3esIPNEIPZejt/guHCcGDtXfq+dpwWSi/dMFJJXjrE2bvRAXlH5v4l95kuu4nT5/h1ozd6JSzxD7asiVF2g7VJf4W+ChSF+3/GpbGm/Gok3LIPhJZt0QQ36/uSpKNdFgdjhtXH45LhnMctRv9XiVX1o61QEDFywbGsNNbYue7z+eBvngntXQRZaExAh2TeVRoTWwxtwyxb0BMFlNrqGuLV/Sxp70MMf4XWdSBrM5ypnRL/ashodSbnZuBdXagPN4De8oD7TwzEcwPryVV7z2DQeeaMggAE4CtUjotvq8w6QeEqNl94GXmLGvo/DSYobzXpbko4ZZKTK1BTxHzNkoqMx4g5Ou/3xmUJhV1ERyusoW9tDr6IDNejDjhBGIl5KQ9Jx9k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199021)(6486002)(71200400001)(478600001)(83380400001)(2616005)(26005)(6506007)(1076003)(186003)(966005)(6512007)(36756003)(316002)(2906002)(38100700002)(41300700001)(122000001)(4326008)(76116006)(66446008)(66476007)(66556008)(66946007)(6916009)(64756008)(8936002)(86362001)(8676002)(38070700005)(5660300002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmJYV2Z5SS9wWDRTR0xuRmxXbEJtZE4rcjhScU9UZjl5RUhGckFsYkxFeTIv?=
 =?utf-8?B?RkpkaWhQMzFRdVhDdWxFakc1UExLVDVTYXZVQjFIR2hUK2hYdjFENGR6UGJn?=
 =?utf-8?B?SDUraE9lZGFlM3NSRUl6YmE1U0l2b29Hd1d2RnZJUkFJSkx0VnJsNWVuODFp?=
 =?utf-8?B?djJsZkZkdWkvd25aUTJwb1ZWRlh1TDR6VUFBYkhhdXpiRXRpZ2huWllXZmpJ?=
 =?utf-8?B?em95Znh5bE5CbUVXZkpIRHhpRjExbkIrOC9FU2wvNjFGZ1U2aHMwYWpsMjNR?=
 =?utf-8?B?NkJYVVZ1SENLSUxYdHBkb2J5TFBNT0tLL1B2S0E0Z1BUbFpCd0dnTXByUnpw?=
 =?utf-8?B?dTRTbFc1cEZuWnB0VWhlREZJeXZSVWZMQWgzWmJxSjMwOFpmQWV5N3JUZ2dk?=
 =?utf-8?B?dFBDODFsVndXRk5RWTk3MXhGV2RheS9iSlVKOEQ1RVE1WkRhM2FnalZ4ZlVH?=
 =?utf-8?B?aXhFLzJDNE5xUzgxcHFxK1BLUS95M3VqZkVFSzluSDB3dFhLNXRWU2xYQjg5?=
 =?utf-8?B?ak9nekVmREdZRllhdlIxZEFVNWVKQXE2Sk1aWXpKejlCMzVSRkdiaDFFL1d6?=
 =?utf-8?B?cmZzdHNKUzI5L1ZZRkNaVjJGd0NsSy9kRm5qUFBRYjQvRkhrVnNPemwwUEtG?=
 =?utf-8?B?aWk1WGY2UG4wNmNpSVQ3cGxCWXFHcjdaUFlZUVp6RVB0cnpXRG1JdUFDZkxl?=
 =?utf-8?B?bDlTREtLTTMxWUhjTEh0aStuUi9wbjFacEI1MlVSTGNkNDd6QWJVd2F4dGhD?=
 =?utf-8?B?ZTdya2laZmUwb1JvSXpKRkM4YTkySTZBR1BLVWtUVW5XVS9MVUsydkxNWU5O?=
 =?utf-8?B?Z1NWNmpLTTFzd05PK0hoQXhoWDJHWnljeG1XRERaRlFXVUd1UnJEeGdCRnN4?=
 =?utf-8?B?azd4SWJ2SnlKWmtNa3NWRUFVK2R2M09YMlpUeDh4SVM4blpaQXlNUXZNOGZ4?=
 =?utf-8?B?czhJRGt5MFFicWRzYVlOc205TC9RbHlkYWZIVHFvQnVSMEZwMnI1MUNqRGJY?=
 =?utf-8?B?d2VGckhxdVRuWFNkUGxKelhocUsyVDI3azYvaCtwbm5pbWx3YWtvQmdUT3M3?=
 =?utf-8?B?NUMzR2tVdU1UOEQrS0M4T3U1YWlKOWRvY0Z3NkNYTVgrSWpLUTBnSjdjRU5h?=
 =?utf-8?B?a3BoS0RqNDFMZHpuTWY3Z1dQZTA2dzhEQm8wN1M0M25HaHJnN3h4aDRlbFdh?=
 =?utf-8?B?RGJQb21yWmt2cExaUUZGSGFyaWt2eXlZSGpzejFFV1Nka3BXTVR6TXFpWUNa?=
 =?utf-8?B?TFd0MmRSanBFWkI0OEdwVndoU2JmWThSUTYwUVVDb1o4MFpSMWJpelpKTkln?=
 =?utf-8?B?Z2pTWWdkcXVnUytmSnMzdUZIT0oxc1RWbytwZGMvR2NoQWFqNnBTWGszbkpx?=
 =?utf-8?B?NkFKdEpXT0N5Y1hSejNEM1N4R2x4WXF0N0RvTk83ckExeHpIWldyYkRhUEJH?=
 =?utf-8?B?aVYzdnc1cHE3bm9CQTJNNldIVXFJQ2c0aHpnUklXRWViMlNXMlJoaGdhd3BM?=
 =?utf-8?B?eVJabVN4Z2R6SFErVDJUNHRyN1N1N1pvNnltL1Q3dUFRUTkzZndBN25ldkV0?=
 =?utf-8?B?M0lZeDVLZWRyRXNqTlc5ZTU4ZjBqZ0pxN0RjZ1NQaG9DNWdjR3QzRklSVW5P?=
 =?utf-8?B?TVZ2OWJ0d1NyMm1MaWF4MzJiUVJHVDdRYTM4WmRTUEl1Q3AxdEhXQnJKQi9x?=
 =?utf-8?B?em01QlZxYWY0WkZtMGQ4WlFjSDhONEkxS0NlOWc1RXFrRFRvNDdvY2tsemJW?=
 =?utf-8?B?eXNOOXlVOE9aaStvQTBvZnpWbHgrLzYzY0FyVXk3ODRSVmF6Z3ZKUzZIdzhx?=
 =?utf-8?B?ay9IRjF3T0NHMFh4ck85OGZWTE5jUE0rUTdqOWpxVzJsSlJpeEY3L3VqeXFr?=
 =?utf-8?B?UGdjUkUzdE5YMDBiVW9OamtPeXRkb3pFWFJORWVSWWpZblIzWlR3VEorWWpQ?=
 =?utf-8?B?dXJMOFJzdFN1OXR4a3FyYkNxVVQvMUZnR3cwSDVhMEpqL0tVWHBLVStJZDdi?=
 =?utf-8?B?ZmdUempXRlF1UklKdENyYWNUNDVSeTVUUmRmNms4a3dvWTIzQ09lYWNkZ1pa?=
 =?utf-8?B?eVNFQXRtWnY4M1NXZVlwTDlnNG01K01KMzdBd25HaENGd2JDeGo3dTFHRmF4?=
 =?utf-8?Q?y+pr604zWVKkjc1cW9SZPwJHr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCF4BBCA0CE98A4E915FD005300F408F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aXVQY252M0YrdU5yYzBFaGJJRVBzNG9vd3p1MWc3RUd2WGNVRnoyUlREMTRs?=
 =?utf-8?B?YmZpbEovc25mRXpsS0o2TS9zNGRLQXlDeTY1dnF6a3BXUHRRSG9mTThyc2ND?=
 =?utf-8?B?MGRPYTdEeWVGUkdwTjRGNlVSTG5Dd0RTbEFRdHNJT25BOERyc1RmOTNuMW1t?=
 =?utf-8?B?VUxTMWhlTVRLaDRvZmRkYjRtVkhZbEFlZ0c5dm9QMXhySGxpckQ0clN1T2VC?=
 =?utf-8?B?WXRtOTJrWE5TYUJDY1F1SmZPdHFNTENxWCtqdm9vaS9aVTU4S1R4eFJHUjZJ?=
 =?utf-8?B?cjhwZEQzK1VabmZML3FqOXh4Ri9rTXlqWlZzQkRYNFdCNTRjMkZIZklhdkkv?=
 =?utf-8?B?NVYyTGZLbnpRSDduUUZkMkYyZ0wzYTJlajMzd05oaHMyVTlLL3RVenJJVXNt?=
 =?utf-8?B?ZmFvb3dKWnR4R0cwdGJYbjNBVlk0U0k4ZCtIM2lzOU9yME12WjY2QW9PZEtk?=
 =?utf-8?B?VGsvYlJScC8wQUQ5by9jTkF3NEJ5M0NGdlhxMmI3TVNadS9YQjZDOVdzZEhy?=
 =?utf-8?B?eERjZHhJZGxQTTJYOUIzTnFISVpTZlQ4WWoxSXNZaENld2JXWUhNci9kTWpD?=
 =?utf-8?B?K1RQSlJTVGNnQ21TT081ZU9UamtmdS9iNFFIOGdickVibFdWSXdtdHdleUZJ?=
 =?utf-8?B?NERNSHNWYzBUUGNqVkJKZnRwaVBpVTd4RDRZZHN5Q0hGNHpjNHgrUU0zTTlp?=
 =?utf-8?B?ODAvL1RVMXBWMExpcDB5eXFKMmRTS1gzNHZNU1FJRG9HMU5ueW05YjRMM2U0?=
 =?utf-8?B?Q3BOOE42K0h6YnRDTmlQNU95a3lMOG4wL1Z6bXNWUE0yelNocldGM2JwL0gx?=
 =?utf-8?B?c1lpWEE3NW5GZnhpMkRCbnlPTkJueG94RERpcmtycjhWTnVpTkZoa1R2d2d5?=
 =?utf-8?B?anE0S244Z0Rpckprck03dXFLc2dkeFBPUEJxeHFIa3lKdVNCcFpQN3FXL0FU?=
 =?utf-8?B?NWhTeStQbCt2aTZ0cVpZaEFNQ0FHUE9sM2xoclc4enR6RWVCZXZEZlNSaW5L?=
 =?utf-8?B?N256anBYNzB3OC9GSDZObW11a05BMlZPNkkyZzhvdUZmTDRZeWg2aFg2MS9o?=
 =?utf-8?B?VWFRdHdYQW1hR2ZOWEdwNW45aUl1bmtmQ291M0pGd04wVTBoSDgwcG5VZ1Vk?=
 =?utf-8?B?MjJFOXJvNDBEbnBjSVN0OUZ6OWdhU2tFYVZzcVVFTG5oS1d6dXI1b3BMRlR6?=
 =?utf-8?B?TFBjYXdmZHVzTlNNdmdUUHk0ek45TW90clZFakxxVVA3U0d0MU1ML0VIRDBr?=
 =?utf-8?B?bUY3UVgranBtODVya0FuUytWZUdqUnVOUmFZUkxkTHJab1NQQT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3cae4b-6264-4a36-ef66-08db832c04d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 23:02:08.5359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5KsamkSXpkAEceU3c/gDqugKMmqEmqFWUnLSk8shAcvHbcaCPp7KeVY8Gxm8cu33jBsNtpXu6re3sxK13OLI2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5504
X-Proofpoint-GUID: JWGDjQ0AtJRnajf8J2s3LZz72sJ5V8eS
X-Proofpoint-ORIG-GUID: JWGDjQ0AtJRnajf8J2s3LZz72sJ5V8eS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_15,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=579 phishscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBKdWwgMTMsIDIwMjMsIEpha3ViIFZhbsSbayB3cm90ZToNCj4gSGkgVGhpbmgsDQo+
IA0KPiBPbiBUdWUsIDIwMjMtMDctMTEgYXQgMjE6NDggKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90
ZToNCj4gPiBIaSBKYWt1YiwNCj4gPiANCj4gPiBPbiBUaHUsIEp1bCAwNiwgMjAyMywgSmFrdWIg
VmFuxJtrIHdyb3RlOg0KPiA+ID4gT24gV2VkLCAyMDIzLTA3LTA1IGF0IDIyOjQ3ICswMDAwLCBU
aGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gPiA+IEkgYnJvdWdodCB1cCB0aGlzIGlucXVpcnkgaW50
ZXJuYWxseS4gUGxlYXNlIHdhaXQgYXMgSSBuZWVkIHRvDQo+ID4gPiA+IHJldmlldw0KPiA+ID4g
PiB0aGlzIGZ1cnRoZXIuIFRoZSBoYW5kbGluZyBmb3IgdGhpcyBtYXkgYmUgZGlmZmVyZW50IGRl
cGVuZGluZyBvbg0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gdGVhbSdzIGZlZWRiYWNrLg0KPiA+ID4g
PiANCj4gPiA+IA0KPiA+ID4gT0s7IGZlZWwgZnJlZSB0byBjb250YWN0IG1lIGlmIEkgY291bGQg
YmUgb2YgYW55IGhlbHAuDQo+ID4gPiANCj4gPiANCj4gPiBTb3JyeSBmb3IgdGhlIGRlbGF5LiBB
ZnRlciBkaXNjdXNzaW9uLCB0aGlzIGJlaGF2aW9yIGlzIHRoZSBzYW1lDQo+ID4gYWNyb3NzDQo+
ID4gZGlmZmVyZW50IGNvbnRyb2xsZXIgdmVyc2lvbnMuIFRoZSBjb25zZW5zdXMgaXMgdG8gZGlz
YWJsZSB0aGlzDQo+ID4gZmVhdHVyZQ0KPiA+IGFsdG9naGV0aGVyLiBUaGVyZSB3aWxsIG5vdCBi
ZSBhbnkgbm90aWNlYWJsZSBwZXJmb3JtYW5jZSBpbXBhY3QuDQo+ID4gDQo+ID4gV291bGQgeW91
IG1pbmQgcmV2aXNlIHRoZSBwYXRjaCB0byBkaXNhYmxlIHRoaXMgZmVhdHVyZSBmb3IgYWxsPw0K
PiANCj4gTm90IGF0IGFsbCwgSSBoYXZlIHNlbnQgYSBuZXcgcmV2aXNpb24gb2YgdGhlIHBhdGNo
Og0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtdXNiLzIwMjMwNzEyMjI0MDM3LjI0OTQ4LTEtbGludXh0YXJkaXNAZ21haWwuY29tL19f
OyEhQTRGMlI5R19wZyFldXZtdkpWcl9BTUNweWQ1OXRpYXY0Q280dThwMFRLenNMcTBXN3lLb3lJ
bE5fSzdXRnYyR1A1N3dYbXNkZHNKb3hzRXE2X0JoeDh5cDVnRzh2QXFlYktoa3ckIA0KPiANCj4g
UmV2ZXJ0aW5nIHRoZSBjb21taXQgYWx0b2dldGhlciBzZWVtZWQgcHJlZmVyYWJsZSB0byBtZSB0
byB1cGRhdGluZyB0aGUNCj4gcmV2aXNpb24tc3BlY2lmaWMgcGF0Y2guIEhvd2V2ZXIsIGlmIHRo
ZSBvdGhlciB3YXkgd291bGQgYmUgYmV0dGVyLCBJDQo+IGNhbiBzZW5kIGFuIHVwZGF0ZWQgcmV2
aXNpb24uDQo+IA0KDQpSZXZlcnRpbmcgaXQgaXMgZmluZSBhbHNvLiBXZSdsbCBrZWVwIHRoZSBk
ZWZhdWx0IHNldHRpbmcgZnJvbQ0KQ29yZUNvbnN1bHRhbnQuDQoNClRoYW5rcywNClRoaW5o
