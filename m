Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2117A4005
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 06:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239676AbjIREPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 00:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239502AbjIREOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 00:14:39 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714DF115;
        Sun, 17 Sep 2023 21:14:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCxnMOEP4pN98lhD7rV7Xju6Ezv+PvLqk3X1lLnnLmSHqyjQFExjYO4UNOom9QThTgFwNTtZnmg3wzc+QzA52ehNHtmzHn6Tw1+PoQZce8roYgGbH53kWpMcJiLntCzmeKu5jia7ADbG2u3kvB6F9RFEjwLtoBxRtb44BFrsfsl2O4TUvwZmJ4Oqz0z6Zsyp6RCbMgAOya3QrbY78jYQkViLAgfCiLVYrr2AKU/+/IunwMKhnWVu37lbhmUWu0UvuKn6AJkrh+lLMGTHporCIaCLUAfsw97snlCJBIFsrknR18ywFK2GdAHx1ueAhkFkNnaNyIiA/9Fv/O6ObEGUFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/mSGZRoFXmKdYxsE0jWoZTVm5LrJi853J+Nz9Mme7k=;
 b=NpDlOReKZSDr/vspu7Vf5RzmCkUNTwAwYEznCHn4IsTNUHSU1z61fPAC1NRIFz5LVX5BM5x4UVxATkg29V4AkcD0BhycssxbohJRMmCo0CwUvqlD6iO2ep9/y4rv9JJVG0pthar+jBcfsMmVMOVZ88w8yNfUcnDcnPVRuBhSU0ut6mCUypTF3180L+t/Z4bzqiIWl/mCvr3iAkSnoaUB2DZQAC15a+YdnFAYTgekFJMJIHNdnKnSJFpdgIwUiLCa0rJl0GW98yeJWdiUWCTxwu42Z5yhGdT1hjyWlT2rj5oXKa/RqpJhi/6NR+PbzLkDx2I7m+M1n52RvjYW67QVpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/mSGZRoFXmKdYxsE0jWoZTVm5LrJi853J+Nz9Mme7k=;
 b=P5vK+wMNuDpVO8SnflM36bDUnM3WrXKqODgy7vVhosIuXYjf0Reiwu0+qXilIrsAFpLet9sJL3TB3O88zi0c7TQ0d5FnXmJh+in952ZKbyOZ0ap1S2NVEry630HB+0kHPmWhEjh+yq2zfO9EpWxsLCwDuCGQkF1//CWYZsZG2kxX6ZH9kWYR+YY3jj7iA1d9ID6hZG0pnSD9v4tuskCMbbPHUSNmCiU10CNBaBqMmg8RhJyP40ACoZ4u5FBzY4vTJ5WwjKCJCenbAToFdBHMLHKeowfzQocW5lwrS+9It+WDbmctgHcZQ4Lr11/ZMDNJhIo8g1YkQD8xPd2A/j3yzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SA1PR12MB5658.namprd12.prod.outlook.com (2603:10b6:806:235::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 04:14:26 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::5cc1:1ea3:4ec5:72af]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::5cc1:1ea3:4ec5:72af%5]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 04:14:26 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH v2 1/3] HID: nvidia-shield: Fix a missing led_classdev_unregister() in the probe error handling path
Date:   Sun, 17 Sep 2023 21:13:43 -0700
Message-Id: <20230918041345.59859-2-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918041345.59859-1-rrameshbabu@nvidia.com>
References: <20230918041345.59859-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0205.namprd05.prod.outlook.com
 (2603:10b6:a03:330::30) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SA1PR12MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b7e1fa-3e46-435d-40bb-08dbb7fdbf48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eETfqazqbfpQOsSgBp+FUgQd0Xwh8KmrQ7MVZOcqvwwMf+ykLZNsTmGqS17jqgB8fyEOV6Y1AeXwV2Lt69F3qA3V1m/SJYle8ZCsAQLHuvjcM8JG0qruPW+0TcDSFgIeHzbXqgQiQOQ8eRIJ9dFYHVhvvJWNhi8kGYWn9S+uN0goLTdQFVLOMtOlFOHL6WfZg+vE39KYtxVlSeEb4iPKjpMR9lAowX/Xs297Y6A+eZbZ4aSjjkJBEqI9FugpqOT4Cy3mhVkyHBBw6fZtoHUfduC1itTCOs90SWCmnY6jeK2hA3wPJ6QoY0nVUiHHr/QbTLLiiu2d1nIVtqVAZl4H5D4BmhRPdLxm5wiBiyCxSRSPa/ELpEZoCMxaBiF/mXwA5c9c1cyAYBiKAxIvgKLEhJ9LpoKO8VnFKP5RP+PEmNyp3kDHOI6m1KzVRlENxn4D3d9ieSX6N1engAYipuDb59Mkzafti7dnfiioZOwP1i+l1k8O7D/R/REQ4bZXi4bvABEjNf83fm+uii3rTh0v4J53CpNI/elevSriZ4JNYu71xyjTZjWAGpMCoYGnVWPh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199024)(1800799009)(186009)(6486002)(5660300002)(6506007)(86362001)(6512007)(54906003)(316002)(66946007)(41300700001)(38100700002)(66556008)(66476007)(110136005)(6666004)(478600001)(2616005)(8936002)(8676002)(26005)(2906002)(36756003)(107886003)(1076003)(4326008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YwoegYwzFl82KOlvnq+GUZqVvMZ7Y5CZLkJStbH3D38oQee63CJFrcazAQKO?=
 =?us-ascii?Q?Fb8Fs6a/jS5sGB/hTW75+GOd7jnsrM6PnsvFlrJ/juKmPxifVGd7DSlZBFKz?=
 =?us-ascii?Q?mo9zwrsW6TCDe1jVWZcghu2NBJcq7YgNNgOh4zX/PuMYYO6mnScE2BOPBRKQ?=
 =?us-ascii?Q?0koJcyQEqEUQJqJjGmOA4ag5gAMG5DQOAhYiFrzsCjm44AnstZZRI65a0Lo5?=
 =?us-ascii?Q?WotnN4Ob9S9icvN3T/qB/NRpkh81YmNlKD0gyKCG7u8BtXDuoqqIrtRM02Yv?=
 =?us-ascii?Q?hog7ZBJeSoEdtsmQpxIPre7pG6NEMJwxsbg7czrVyUZmEQcPOJwh90dpxUW9?=
 =?us-ascii?Q?22aA9LdEeZ8MafiP0CW0gJhpWnOOscdebKV9F5S9/O2XvKIAjUVIzqYtXxyF?=
 =?us-ascii?Q?n9ZN4BGYNJrfbUX3eSWpbFUK8a8W2oLX7ahSEJbaPxzDgCxFNdjuYdb4FNrj?=
 =?us-ascii?Q?0Q/iE1AlEgZiBtny8HB1HybvzT1q7VES63AnAtU8MuOa22N1DzDLNrnwU4Os?=
 =?us-ascii?Q?QwCeI3kHs/1AvFYkifeuSWX0vkz+J1bShOP8Uta3Xl82wmIRnNsuCrk88C6X?=
 =?us-ascii?Q?4tKkLT5fYFnce0uavnYZJ6OyeOiBF6M4H8VqggPHjD052ogo5nb2lpAYTZuN?=
 =?us-ascii?Q?NZjwlKppL5UBJKMjhXkz0rqTRs8XlVKsDj4cLyr3zktSrQulnanTtjPt78zg?=
 =?us-ascii?Q?xSmbui8gcqZEDJpsSfN6witHIbulFD/Xdl0uuj5V12Pm/DU+QmHM8/nEQUlE?=
 =?us-ascii?Q?JSujIzwHCP1c9kZGgM39BRPVucV2ldE1pLUuop1hvuGVF39YUaGNY0bJu22h?=
 =?us-ascii?Q?kxkXoW9EDun6X1XRqr1gnJdYkbD6feeWMip0/1uGSfQdTZeJ/sKcNh5trygj?=
 =?us-ascii?Q?IlfzjIBNNYNghM5Z56icZXhgq18AsxB2NdMFh5tsN+HLMPohTLY+/2FzZ0Q4?=
 =?us-ascii?Q?vDo7sxSqCd6u/hGph5BvaZI/UvZW7kzlW4fXQ1nScQFYzmkyfzzhjuRSg3V1?=
 =?us-ascii?Q?eZ7mmwIlbsnDObiOgBD7rYl1IWp5rW/jLl6vivILXZKgLYxtwg1YA+9bk6v2?=
 =?us-ascii?Q?4tZ2U+mUq0h85Fbv6EgPhbVLmK57JnPdQq+fZDM1WohN4GQ5gZYLc5CZGQQV?=
 =?us-ascii?Q?IwPvWMreQVkzXIScmbdmFfAotS+Grp2WI7QQHxi75T0oOdLWh50H6mijHUhM?=
 =?us-ascii?Q?DXQ51RxN19LGQjKfXdLKQRm1AO0Ya08qxX8jCKLEGld4MTVs7zPVZnkYx6Cg?=
 =?us-ascii?Q?xnbkYhNdcl34HHNJNG5TU2q3x7yrMffqMGtxt1O/yFbzxx/f+wHvC7kFwJEu?=
 =?us-ascii?Q?drbVa+7ZmPYEArxRGYtmYqd9o8HdTsu8sfUuBUQl7TVmZXuVPYGRJ5OzAPii?=
 =?us-ascii?Q?c+91oTmbIxBoRMX98CjV6ybSfjlLFJlE1BVgr0ADn+96OFLha0hWtCClUV8q?=
 =?us-ascii?Q?WIj+6mMQ5Uii8X2BKgr6ehD2uujwVsyNkTT32WThn2TqT4sXz2c0rYRQ9dDK?=
 =?us-ascii?Q?Wccfu1+Y0QJCZgKbQB3sE2kjGfXS1JpZNzgvw9bQfKBW3tzUFZ6wRCYNlaUW?=
 =?us-ascii?Q?fBzoLAKo/GjjYf9tTasaa+oowDrWRcxvuk7AEHSv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b7e1fa-3e46-435d-40bb-08dbb7fdbf48
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 04:14:26.7984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXHfaatUL3Su7Yc4ssEyELrknnz7CDMAUn9qTAoRr0/JQoz9eRyb/K2mSPUo8uh1H5Tfc+3MY7wWs16p4HUJ7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5658
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

The commit in Fixes updated the error handling path of
thunderstrike_create() and the remove function but not the error handling
path of shield_probe(), should an error occur after a successful
thunderstrike_create() call.

Add the missing call. Make sure it is safe to call in the probe error
handling path by preventing the led_classdev from attempting to set the LED
brightness to the off state on unregister.

Fixes: f88af60e74a5 ("HID: nvidia-shield: Support LED functionality for Thunderstrike")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---

Notes:
    Changes:
    
      v1->v2:
        - Add the LED_RETAIN_AT_SHUTDOWN flag to prevent
          led_classdev_unregister from trying to set the LED to off before a
          successful call to hid_hw_start.

 drivers/hid/hid-nvidia-shield.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-nvidia-shield.c b/drivers/hid/hid-nvidia-shield.c
index 43784bb57d3f..c144641452d3 100644
--- a/drivers/hid/hid-nvidia-shield.c
+++ b/drivers/hid/hid-nvidia-shield.c
@@ -801,7 +801,7 @@ static inline int thunderstrike_led_create(struct thunderstrike *ts)
 	led->name = devm_kasprintf(&ts->base.hdev->dev, GFP_KERNEL,
 				   "thunderstrike%d:blue:led", ts->id);
 	led->max_brightness = 1;
-	led->flags = LED_CORE_SUSPENDRESUME;
+	led->flags = LED_CORE_SUSPENDRESUME | LED_RETAIN_AT_SHUTDOWN;
 	led->brightness_get = &thunderstrike_led_get_brightness;
 	led->brightness_set = &thunderstrike_led_set_brightness;
 
@@ -1076,6 +1076,7 @@ static int shield_probe(struct hid_device *hdev, const struct hid_device_id *id)
 err_haptics:
 	if (ts->haptics_dev)
 		input_unregister_device(ts->haptics_dev);
+	led_classdev_unregister(&ts->led_dev);
 	return ret;
 }
 
-- 
2.40.1

